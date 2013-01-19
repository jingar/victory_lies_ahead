class Staff < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_name, :password, :password_confirmation, :type
end
