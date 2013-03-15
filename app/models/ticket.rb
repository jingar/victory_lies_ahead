
# == Schema Information
#
# Table name: tickets
#
#  id                        :integer          not null, primary key
#  first_name                :string(255)
#  last_name                 :string(255)
#  email                     :string(255)
#  address                   :string(255)
#  order_id                  :string(255)
#  adult_tickets_bought      :integer
#  concession_tickets_bought :integer
#  used                      :boolean          default(FALSE)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class Ticket < ActiveRecord::Base  

  attr_accessible :address, :email, :first_name, :last_name, :order_id, :adult_tickets_bought, :concession_tickets_bought, :used

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :order_id, presence:   true,
                    uniqueness: { case_sensitive: false }

  validate :check_tickets?

  def check_tickets?()
    if adult_tickets_bought == 0 && concession_tickets_bought == 0
      errors.add(:base, "You must reserve at least one ticket")
      return false
    else
      return true
    end
  end


  def self.search(search)
    if search
      find(:all, :conditions => ['order_id LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end

