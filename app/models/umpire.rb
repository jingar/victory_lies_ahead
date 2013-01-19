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
#

class Umpire < ActiveRecord::Base
    attr_accessible :email, :first_name, :last_name

    has_many :matches

    before_save { |user| user.email = email.downcase }
    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
  
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence:   true,
		    format:     { with: VALID_EMAIL_REGEX },
		    uniqueness: { case_sensitive: false }

end
