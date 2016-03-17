class Conference < ActiveRecord::Base
  belongs_to :league
  has_many :divisions
end
