class Ticket < ActiveRecord::Base
  attr_accessible :address, :email, :first_name, :last_name, :order_id, :tickets_bought, :used

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :order_id, presence:   true,
                    uniqueness: { case_sensitive: false }

  validates :tickets_bought, presence:   true
end

