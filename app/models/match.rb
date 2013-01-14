class Match < ActiveRecord::Base
  attr_accessible :when
  has_and_belongs_to_many :teams
  has_many :facts

  validates :when, presence: true
  validates :team_id, presence: true
end
