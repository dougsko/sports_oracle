class StatEntriesController < ApplicationController
    before_action :set_stat_entry, only: [:show, :edit, :update, :destroy]

    # GET /stat_entries
    # GET /stat_entries.json
    def index
        @stat_entries = StatEntry.all.order(:year, :week)
    end

    # GET /stat_entries/1
    # GET /stat_entries/1.json
    def show
    end

    # GET /stat_entries/new
    def new
        @teams = Team.all
        @stats = Stat.all
        @stat_entry = StatEntry.new
    end

    # GET /stat_entries/1/edit
    def edit
        @teams = Team.all
        @stats = Stat.all
    end

    # POST /stat_entries
    # POST /stat_entries.json
    def create
        @teams = Team.all
        @stats = Stat.all
        @stat_entry = StatEntry.new(stat_entry_params)

        respond_to do |format|
            if @stat_entry.save
                format.html { redirect_to @stat_entry, notice: 'Stat entry was successfully created.' }
                format.json { render :show, status: :created, location: @stat_entry }
            else
                format.html { render :new }
                format.json { render json: @stat_entry.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /stat_entries/1
    # PATCH/PUT /stat_entries/1.json
    def update
        respond_to do |format|
            if @stat_entry.update(stat_entry_params)
                format.html { redirect_to @stat_entry, notice: 'Stat entry was successfully updated.' }
                format.json { render :show, status: :ok, location: @stat_entry }
            else
                format.html { render :edit }
                format.json { render json: @stat_entry.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /stat_entries/1
    # DELETE /stat_entries/1.json
    def destroy
        @stat_entry.destroy
        respond_to do |format|
            format.html { redirect_to stat_entries_url, notice: 'Stat entry was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_stat_entry
        @stat_entry = StatEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stat_entry_params
        params.require(:stat_entry).permit(:name, :year, :week, :value, :belongs_to)
    end
end
