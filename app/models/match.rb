# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  when       :datetime
#  homeTeam   :string(255)
#  awayTeam   :string(255)
#  pitch      :integer
#  umpire     :string(255)
#  homeGoals  :integer
#  awayGoals  :integer
#  team_id_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  umpire_id  :integer
#  team_id    :integer
#

class Match < ActiveRecord::Base
  attr_accessible :awayGoals, :awayTeam, :homeGoals, :homeTeam, :pitch, :umpire, :when, :umpires_attributes, :teams_attributes , :tournament_id
  
  has_one :teams
  has_many :scores
  accepts_nested_attributes_for :teams
  
  has_one :umpires
  accepts_nested_attributes_for :umpires

  belongs_to :tournament
  
  validates :pitch, presence: true


  def teams
    [homeTeam,awayTeam]
    end

  def players
    cur_players = teams.map do |p|
     Wattball.where(["team_id = ?",p])
    end

    cur_players.flatten
  end
end
