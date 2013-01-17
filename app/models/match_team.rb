class MatchTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :match

  validates :team_id, presence: true
  validates :match_id, presence: true
  # attr_accessible :title, :body
end
