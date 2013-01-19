# == Schema Information
#
# Table name: match_teams
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  match_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MatchTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :match

  validates :team_id, presence: true
  validates :match_id, presence: true
  # attr_accessible :title, :body
end
