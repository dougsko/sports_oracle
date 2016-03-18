# to add a new stat to games
#
# Game.all.each do |g|
#     g.home_rush_yards = g.stat_lines.where(team_id: Team.where(short_name: g.home_team).first.id).sum(:rush_yards)
#     g.away_rush_yards = g.stat_lines.where(team_id: Team.where(short_name: g.away_team).first.id).sum(:rush_yards)
#     g.save
# end
#
#
class GamesController < ApplicationController
    before_action :set_game, only: [:show, :edit, :update, :destroy]

    # GET /games
    # GET /games.json
    def index
        @teams = Team.all
        @games = Game.order(:year).order(:week).page(params[:page])
    end

    # GET /games/1
    # GET /games/1.json
    def show
    end

    # GET /games/new
    def new
        @game = Game.new
    end

    # GET /games/1/edit
    def edit
    end

    # POST /games
    # POST /games.json
    def create
        @game = Game.new(game_params)

        respond_to do |format|
            if @game.save
                format.html { redirect_to @game, notice: 'Game was successfully created.' }
                format.json { render :show, status: :created, location: @game }
            else
                format.html { render :new }
                format.json { render json: @game.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /games/1
    # PATCH/PUT /games/1.json
    def update
        respond_to do |format|
            if @game.update(game_params)
                format.html { redirect_to @game, notice: 'Game was successfully updated.' }
                format.json { render :show, status: :ok, location: @game }
            else
                format.html { render :edit }
                format.json { render json: @game.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /games/1
    # DELETE /games/1.json
    def destroy
        @game.destroy
        respond_to do |format|
            format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    # GET /games/update_games
    def update_games
        year = Date.today.year
        games = JSON.parse(Net::HTTP.get(URI("https://fantasysupercontest.com/nfl-export?year=#{year}&format=json")))
        games.each do |game|
            if Game.where(year: game["year"], week: game["week"], home_team: game["home_team"]).size == 0
                new_game = Game.new(game)
                new_game.save
            end
            Game.where(year: game["year"], week: game["week"], home_team: game["home_team"]).each do |lookup_game|
                game.keys.each do |key|
                    lookup_game[key] = game[key]
                end
                lookup_game.save
            end
        end

        redirect_to games_url, notice: 'Games were successfully updated.'
    end



    private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
        @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
        params.require(:game).permit(:week, :year, :game_time, :away_team, :home_team, :away_line, :home_line, :away_score, :home_score, :away_ats_result, :home_ats_result)
    end
end
