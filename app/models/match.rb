class Match < ActiveRecord::Base
  belongs_to :umpire
  has_many :teams, through: :matches_teams
  attr_accessible :when

  validates :when, presence: true
end
