# == Schema Information
#
# Table name: umpires
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  umpire_id  :integer
#  match_id   :integer
#

class Umpire < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name
  
  belongs_to :matches
  validates_uniqueness_of :first_name, :scope => :last_name
end
