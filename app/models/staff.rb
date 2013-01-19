# == Schema Information
#
# Table name: staffs
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  type            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_name       :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#

class Staff < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :user_name,
    :password, :password_confirmation, :type
    has_secure_password

    before_save { |staff| staff.user_name = user_name.downcase }
    before_save :create_remember_token

    validates :first_name, presence: true, length: {maximum: 50}
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_conformation, presence: true
    validates :type, presence: true

	private
	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end
end
