# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  sport           :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  address         :string(255)
#  telephone       :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :address, :telephone,
  :password, :password_confirmation, :sport
  has_secure_password
  has_many :hurdles
  has_many :teams
  

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :sport, presence: true
  validates :address, presence: true
  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
