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

