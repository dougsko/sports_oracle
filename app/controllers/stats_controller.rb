class StatsController < ApplicationController
    before_action :set_stat, only: [:show, :edit, :update, :destroy, :calculate_all, :export]

    # GET /stats
    # GET /stats.json
    def index
        @stats = Stat.all
    end

    # GET /stats/1
    # GET /stats/1.json
    def show
        win_prediction
    end

    # GET /stats/new
    def new
        @compare_columns = Game.column_names
        @stat = Stat.new
    end

    # GET /stats/1/edit
    def edit
        @compare_columns = Game.column_names
    end

    # GET /stats/1/calculate_all
    def calculate_all
        # first, delete all stat entries for this stat
        StatEntry.where(stat_id: @stat.id).each do |stat_entry|
            stat_entry.delete
        end

        # create week 0 stat entries
        Team.all.each do |team|
            rating = Rating.new(1500, rand(348..352), 0.06)
            first_year = Game.order(:year).first.year
            stat_entry = StatEntry.new(week: 0, year: first_year, team_id: team.id, stat_id: @stat.id, rating: rating[:rating], rating_deviation: rating[:rating_deviation], volatility: rating[:volatility])
            stat_entry.save
        end

        # create all other entries
        games = Game.where("#{@stat.home_compare_field} >= 0").order(:year, :week)
        games.each do |game|
            if game[@stat.home_compare_field] > game[@stat.away_compare_field]
                winner = Team.where(short_name: game.home_team)[0]
                loser = Team.where(short_name: game.away_team)[0]
            else
                winner = Team.where(short_name: game.away_team)[0]
                loser = Team.where(short_name: game.home_team)[0]
            end

            winner_stat = StatEntry.where(stat_id: @stat.id, team_id: winner.id).order(:year).order(:week).last
            loser_stat = StatEntry.where(stat_id: @stat.id, team_id: loser.id).order(:year).order(:week).last

            winner_rating = Rating.new(winner_stat.rating, winner_stat.rating_deviation, winner_stat.volatility)
            loser_rating = Rating.new(loser_stat.rating, loser_stat.rating_deviation, loser_stat.volatility)

            period = Glicko2::RatingPeriod.from_objs([winner_rating, loser_rating])
            period.game([winner_rating, loser_rating], [1, 2])
            next_period = period.generate_next
            next_period.players.each { |p| p.update_obj }

            new_winner_stat = StatEntry.new(week: game.week, year: game.year, team_id: winner.id, stat_id: @stat.id,
                                            rating: next_period.players[0].obj[:rating], rating_deviation: next_period.players[0].obj[:rating_deviation],
                                            volatility: next_period.players[0].obj[:volatility])
            new_loser_stat = StatEntry.new(week: game.week, year: game.year, team_id: loser.id, stat_id: @stat.id,
                                           rating: next_period.players[1].obj[:rating], rating_deviation: next_period.players[1].obj[:rating_deviation],
                                           volatility: next_period.players[1].obj[:volatility])

            new_winner_stat.save
            new_loser_stat.save
        end

        redirect_to @stat, notice: 'Stat Entries created.'
        return
    end

    def win_prediction
        @right_win_predictions = 0
        @right_line_predictions = 0
        @total_predictions = 0
        @games = Game.where.not('home_score' => nil).order(year: :asc, week: :asc)
        @games.each do |game|
            home_team = Team.where(short_name: game.home_team)[0]
            away_team = Team.where(short_name: game.away_team)[0]
            home_stat_entry = StatEntry.where(stat_id: @stat.id, year: game.year, week: game.week - 1, team_id: home_team.id).where.not('rating' => nil).first
            away_stat_entry = StatEntry.where(stat_id: @stat.id, year: game.year, week: game.week - 1, team_id: away_team.id).where.not('rating' => nil).first
            if home_stat_entry and away_stat_entry
                if home_stat_entry.rating - 2*home_stat_entry.rating_deviation > away_stat_entry.rating + 2*away_stat_entry.rating_deviation
                    if game.home_score > game.away_score
                        @right_win_predictions += 1
                    end
                    if game.home_ats_result == 'win'
                        @right_line_predictions += 1
                    end
                elsif away_stat_entry.rating - 2*away_stat_entry.rating_deviation > home_stat_entry.rating + 2*home_stat_entry.rating_deviation 
                    if game.away_score > game.home_score
                        @right_win_predictions += 1
                    end
                    if game.away_ats_result == 'win'
                        @right_line_predictions += 1
                    end
                end

                if home_stat_entry.rating - 2*home_stat_entry.rating_deviation > away_stat_entry.rating + 2*away_stat_entry.rating_deviation or
                    away_stat_entry.rating - 2*away_stat_entry.rating_deviation > home_stat_entry.rating + 2*home_stat_entry.rating_deviation
                    @total_predictions += 1
                end
            end
        end
    end

    # GET /stats/1/export
    # show stat_diff | score_diff
    def export
        @entries = []
        lines = []
        lines << "Rating Diff,Score Diff"
        @games = Game.where('home_score >= 0')
        stat_entries = StatEntry.where(stat_id: @stat.id)
        @games.each do |game|
            home_team = Team.where(short_name: game.home_team)[0]
            away_team = Team.where(short_name: game.away_team)[0]

            home_stat_entry = StatEntry.where(stat_id: @stat.id, week: game.week-1, year: game.year, team_id: home_team.id)[0]
            away_stat_entry = StatEntry.where(stat_id: @stat.id, week: game.week-1, year: game.year, team_id: away_team.id)[0]

            if home_stat_entry and away_stat_entry
                if home_stat_entry.rating
                    if home_stat_entry.rating - 2*home_stat_entry.rating_deviation > away_stat_entry.rating + 2*away_stat_entry.rating_deviation
                        lines << "#{home_stat_entry.rating - away_stat_entry.rating},#{game.home_score - game.away_score}"
                    end
                    if away_stat_entry.rating - 2*away_stat_entry.rating_deviation > home_stat_entry.rating + 2*home_stat_entry.rating_deviation
                        lines << "#{away_stat_entry.rating - home_stat_entry.rating},#{game.away_score - game.home_score}"
                    end
                end
            end
        end

        csv_string = lines.join("\n")

        respond_to do |format|
            format.html { render :export }
            format.json { render json: @entries }
            format.csv { send_data(csv_string, :filename => "#{@stat.name.camelize}.csv", :type => "text/csv") }
        end

    end



    # POST /stats
    # POST /stats.json
    def create
        @compare_columns = Game.column_names
        @stat = Stat.new(stat_params)

        respond_to do |format|
            if @stat.save
                format.html { redirect_to @stat, notice: 'Stat was successfully created.' }
                format.json { render :show, status: :created, location: @stat }
            else
                format.html { render :new }
                format.json { render json: @stat.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /stats/1
    # PATCH/PUT /stats/1.json
    def update
        @compare_columns = Game.column_names
        respond_to do |format|
            if @stat.update(stat_params)
                format.html { redirect_to @stat, notice: 'Stat was successfully updated.' }
                format.json { render :show, status: :ok, location: @stat }
            else
                format.html { render :edit }
                format.json { render json: @stat.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /stats/1
    # DELETE /stats/1.json
    def destroy
        @stat.destroy
        respond_to do |format|
            format.html { redirect_to stats_url, notice: 'Stat was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_stat
        @stat = Stat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stat_params
        params.require(:stat).permit(:name, :predictive_power, :compare_field_a, :compare_field_b)
    end

end
