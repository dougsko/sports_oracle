class TeamsController < ApplicationController
    before_action :set_team, only: [:show, :edit, :update, :destroy, :export]

    # GET /teams
    # GET /teams.json
    def index
        @divisions = Division.all
        @teams = Team.all
        @good_bets = {}
        @teams.each do |team|
            last_game_played = Game.where('(home_team = ? OR away_team = ?) AND home_score >= 0', team.short_name, team.short_name).order(:year, :week).last
            if last_game_played.week == 17
                upcoming_game = last_game_played
            else
                upcoming_game = Game.where('home_team = ? OR away_team = ?', team.short_name, team.short_name).where(year: last_game_played.year, week: last_game_played.week + 1).order(:year, :week).last
            end
            if upcoming_game.home_team == team.short_name
                other_team = Team.where(short_name: upcoming_game.away_team)[0]
            else
                other_team = Team.where(short_name: upcoming_game.home_team)[0]
            end

            if last_game_played.week == 17
                team_last_stat_entry = StatEntry.where(stat_id: 1, year: last_game_played.year, week: last_game_played.week-2, team_id: team.id)[0]
                other_team_last_stat_entry = StatEntry.where(stat_id: 1, year: last_game_played.year, week: last_game_played.week-2, team_id: other_team.id)[0]
            else
                team_last_stat_entry = StatEntry.where(stat_id: 1, year: last_game_played.year, week: last_game_played.week-1, team_id: team.id)[0]
                other_team_last_stat_entry = StatEntry.where(stat_id: 1, year: last_game_played.year, week: last_game_played.week-1, team_id: other_team.id)[0]
            end

            if team_last_stat_entry.rating - 2*team_last_stat_entry.rating_deviation > other_team_last_stat_entry.rating + 2*other_team_last_stat_entry.rating_deviation
                @good_bets[team.id] = "lightgreen"
            end

        end



    end

    # GET /teams/1
    # GET /teams/1.json
    def show
        @stats = Stat.all
        #@games = Game.where('home_team = ? OR away_team = ?', @team.short_name, @team.short_name).order(year: :asc, week: :asc)
        @games = Game.where('home_team = ? OR away_team = ?', @team.short_name, @team.short_name).order(:year).order(:week).page(params[:page])
        @stat_entries = {} 
        @good_bets = {}
        @stats.each do |stat|
            @stat_entries[stat.id] = []
            @games.each do |game|
                @stat_entries[stat.id][game.id] = {}
                if game.home_team == @team.short_name
                    score_diff = game.home_score - game.away_score if game.home_score != nil
                else
                    score_diff = game.away_score - game.home_score if game.home_score != nil
                end

                if Team.where(short_name: game.home_team)[0].id != @team.id
                    other_team = Team.where(short_name: game.home_team).first
                else
                    other_team = Team.where(short_name: game.away_team).first
                end

                last_stat_entry1 = StatEntry.where(stat_id: stat.id, year: game.year, week: game.week - 1, team_id: @team.id).where.not('rating' => nil).first
                last_stat_entry2 = StatEntry.where(stat_id: stat.id, year: game.year, week: game.week - 1, team_id: other_team.id).where.not('rating' => nil).first

                if last_stat_entry1 and last_stat_entry2
                    if last_stat_entry1.rating - 2*last_stat_entry1.rating_deviation > last_stat_entry2.rating + 2*last_stat_entry2.rating_deviation
                        @good_bets[game.id] = "lightgreen"
                        if game.home_team == @team.short_name
                            if game.home_ats_result == "win"
                                @good_bets[game.id] = "green"
                            end
                        else
                            if game.away_ats_result == "win"
                                @good_bets[game.id] = "green"
                            end
                        end
                    end
                end

                stat_entry1 = StatEntry.where(stat_id: stat.id, week: game.week, year: game.year, team_id: @team.id).first
                stat_entry2 = StatEntry.where(stat_id: stat.id, week: game.week, year: game.year, team_id: other_team.id ).first

                if stat_entry1 and stat_entry2
                    rating_diff = (stat_entry1.rating - stat_entry2.rating).to_i
                    @stat_entries[stat.id] << {game.id => {:team_rating => stat_entry1.rating.to_i, 
                                                           :other_team_rating => stat_entry2.rating.to_i, 
                                                           :rating_diff => rating_diff,
                                                           :score_diff => score_diff}}
                end
            end
        end

    end

    # GET /teams/new
    def new
        @divisions = Division.all
        @team = Team.new
    end

    # GET /teams/1/edit
    def edit
        @divisions = Division.all
    end

    # POST /teams
    # POST /teams.json
    def create
        @divisions = Division.all
        @team = Team.new(team_params)

        respond_to do |format|
            if @team.save
                format.html { redirect_to @team, notice: 'Team was successfully created.' }
                format.json { render :show, status: :created, location: @team }
            else
                format.html { render :new }
                format.json { render json: @team.errors, status: :unprocessable_entity }
            end
        end
    end

    # GET /teams/1/export
    def export
        lines = []
        lines << "Rating,Rating Deviation"
        @entries = StatEntry.where(team_id: @team.id).order(:year, :week)
        @entries.map{ |se| lines << "#{se.rating.to_i},#{se.rating_deviation.to_i}"}
        csv_string = lines.join("\n")

        respond_to do |format|
            format.html { render :export }
            format.json { render json: @entries }
            format.csv { send_data(csv_string, :filename => "#{@team.name.camelize}.csv", :type => "text/csv") }
        end
    end

    # PATCH/PUT /teams/1
    # PATCH/PUT /teams/1.json
    def update
        respond_to do |format|
            if @team.update(team_params)
                format.html { redirect_to @team, notice: 'Team was successfully updated.' }
                format.json { render :show, status: :ok, location: @team }
            else
                format.html { render :edit }
                format.json { render json: @team.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /teams/1
    # DELETE /teams/1.json
    def destroy
        @team.destroy
        respond_to do |format|
            format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
        @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
        params.require(:team).permit(:name, :short_name, :city, :division_id)
    end
end
