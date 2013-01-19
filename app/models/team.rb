# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  team_name  :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ActiveRecord::Base
    attr_accessible :team_name
    belongs_to :user
    has_many :wattballs
    has_many :matches, through: :matches_teams

    validates :team_name, presence: true
    validates :user_id, presence: true
end