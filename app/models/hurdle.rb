class Hurdle < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :qualification
    belongs_to :user

	validates :user_id, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
end
