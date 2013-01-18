class Team < ActiveRecord::Base
    attr_accessible :team_name
    belongs_to :user
    has_many :wattballs
    has_many :matches, through: :matches_teams

    validates :team_name, presence: true
    validates :user_id, presence: true
end
