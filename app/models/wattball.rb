# == Schema Information
#
# Table name: wattballs
#
#  id         :integer          not null, primary key
#  team_name  :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Wattball < ActiveRecord::Base
    attr_accessible :team_name, :first_name, :last_name
    belongs_to :user

    validates :team_name, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
end
