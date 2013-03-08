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
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Match < ActiveRecord::Base
  attr_accessible :awayGoals, :awayTeam, :homeGoals, :homeTeam, :pitch, :umpire, :when, :umpires_attributes, :teams_attributes
  
  has_one :teams
  accepts_nested_attributes_for :teams
  
  has_one :umpires
  accepts_nested_attributes_for :umpires
  
  validates :pitch, presence: true

end
