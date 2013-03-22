# == Schema Information
#
# Table name: wattballs
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :integer
#

class Wattball < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :team_id, :goals
  belongs_to :team,:counter_cache => :number_of_players
  before_destroy :validate_wattballs?
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def validate_wattballs?
    errors.add(:base, "Team cannot have less than 11 players!") unless team.wattballs.count >11
    errors.blank?
  end
end
