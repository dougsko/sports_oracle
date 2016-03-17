class Player < ActiveRecord::Base
    validates :team, presence: true
    belongs_to :team
    has_many :stat_lines
end
