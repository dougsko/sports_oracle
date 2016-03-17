class StatLinesController < ApplicationController
    before_action :set_stat_line, only: [:show, :edit, :update, :destroy]

    # GET /stat_lines
    # GET /stat_lines.json
    def index
        @stat_lines = StatLine.all
    end

    # GET /stat_lines/1
    # GET /stat_lines/1.json
    def show
    end

    # GET /stat_lines/new
    def new
        @stat_line = StatLine.new
    end

    # GET /stat_lines/1/edit
    def edit
    end

    # POST /stat_lines
    # POST /stat_lines.json
    def create
        @stat_line = StatLine.new(stat_line_params)

        respond_to do |format|
            if @stat_line.save
                format.html { redirect_to @stat_line, notice: 'Stat line was successfully created.' }
                format.json { render :show, status: :created, location: @stat_line }
            else
                format.html { render :new }
                format.json { render json: @stat_line.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /stat_lines/1
    # PATCH/PUT /stat_lines/1.json
    def update
        respond_to do |format|
            if @stat_line.update(stat_line_params)
                format.html { redirect_to @stat_line, notice: 'Stat line was successfully updated.' }
                format.json { render :show, status: :ok, location: @stat_line }
            else
                format.html { render :edit }
                format.json { render json: @stat_line.errors, status: :unprocessable_entity }
            end
        end
    end

    def import_all
        stat_lines = []
        Game.minimum(:year).upto(Game.maximum(:year)) do |year|
            puts "working on year: " + year.to_s
            1.upto(Game.maximum(:week)) do |week|
                puts "working on week: " + week.to_s
                JSON.parse(NflData::API::Statline.get_passing(week, year)).collect { |s| StatLine.create(s) }
                JSON.parse(NflData::API::Statline.get_rushing(week, year)).collect { |s| StatLine.create(s) }
                #stat_lines << JSON.parse(NflData::API::Statline.get_receiving(week, year))
            end
        end
    end




    # DELETE /stat_lines/1
    # DELETE /stat_lines/1.json
    def destroy
        @stat_line.destroy
        respond_to do |format|
            format.html { redirect_to stat_lines_url, notice: 'Stat line was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_stat_line
        @stat_line = StatLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stat_line_params
        params.require(:stat_line).permit(:nfl_player_id, :week, :year, :rush_atts, :rush_yards, :rush_tds, :fumbles, :pass_comp, :pass_att, :pass_yards, :pass_tds, :ints, :qb_rating, :receptions, :rec_yards, :rec_tds)
    end
end
