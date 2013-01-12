class Wattball < ActiveRecord::Base
  attr_accessible :team_name, :first_name, :last_name
  belongs_to :user

 	validates :team_name, presence: true
	validates :first_name, presence: true
 	validates :last_name, presence: true

end
