class StatLine < ActiveRecord::Base
    belongs_to :player
    belongs_to :game
    belongs_to :team
    before_create :set_player_game
    #after_touch :set_game

    protected
    def set_player_game
        player = Player.where(nfl_player_id: self.nfl_player_id).first
        if player
            game = Game.where('home_team = ? or away_team = ?', player.team.short_name, player.team.short_name).where(year: self.year, week: self.week).first
            self.player = player
            self.game = game
        end
    end

    protected
    def set_game
        player = self.player
        if player and player.team
            game = Game.where('home_team = ? or away_team = ?', player.team.short_name, player.team.short_name).where(year: self.year, week: self.week).first
            self.game_id = game.id
        end
    end

end
