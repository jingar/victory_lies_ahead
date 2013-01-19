# == Schema Information
#
# Table name: staffs
#
#  id                    :integer          not null, primary key
#  first_name            :string(255)
#  last_name             :string(255)
#  password              :string(255)
#  password_confirmation :string(255)
#  type                  :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_name             :string(255)
#

class Staff < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_name, :password, :password_confirmation, :type
end
