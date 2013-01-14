class Team < ActiveRecord::Base
    attr_accessible :team_name
    belongs_to :user
    has_many :wattballs

    validates :team_name, presence: true
    validates :user_id, presence: true
end
