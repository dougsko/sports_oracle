class Team < ActiveRecord::Base
    belongs_to :division
    has_many :games
    has_many :stat_entries
    has_many :players
end
