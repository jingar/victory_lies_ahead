# == Schema Information
#
# Table name: teams
#
#  id                :integer          not null, primary key
#  team_name         :string(255)
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  match_teams_id    :integer
#  wins              :integer          default(0)
#  draws             :integer          default(0)
#  losses            :integer          default(0)
#  goalsfor          :integer          default(0)
#  goalsagainst      :integer          default(0)
#  number_of_players :integer
#

class Team < ActiveRecord::Base
  attr_accessible :team_name, :wattballs_attributes, :user_id, :wins, :draws, :losses, :goalsfor, :goalsagainst,:number_of_players
  belongs_to :user
  has_many :wattballs, dependent: :destroy
  has_and_belongs_to_many :matches
  has_many :match_teams
  has_many :matches, through: :match_teams 
  accepts_nested_attributes_for :wattballs, :allow_destroy => true

  validates :team_name, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :team_name

end
