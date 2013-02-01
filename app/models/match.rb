# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  when       :datetime
#  umpire_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Match < ActiveRecord::Base
  attr_accessible :when, :pitch, :opponent, :umpire
  belongs_to :umpire
  has_many :teams, through: :match_teams
  
  validates :when, presence: true
  validates :pitch, presence: true
  validates :umpire, presence: true
  validates :umpire_id, presence:true
end
