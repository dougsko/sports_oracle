class Division < ActiveRecord::Base
  belongs_to :conference
  has_many :teams
end
