class StatEntry < ActiveRecord::Base
    belongs_to :stat
    belongs_to :team
end
