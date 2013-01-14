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
    attr_accessible :first_name, :last_name
    belongs_to :team

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :team_id, presence: true
end
