# == Schema Information
#
# Table name: hurdles
#
#  id            :integer          not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  qualification :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  gender        :string(255)
#

class Hurdle < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :qualification, :gender, :user_id

  belongs_to :user
  has_many :heats, through: :heat_hurdles
  has_many :heat_hurdles
  has_many :heat_results

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true, length: {maximum: 1} 
#  REGEX = /(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d/
#  TIME_REGEX = /^(20|21|22|23|[01]\d|\d)(([:.][0-5]\d){1,2})$/
#  validates :qualification, format: { with:  REGEX, message: "not in format hh:mm:ss" }

  def name
    "#{first_name} #{last_name}"
  end
end
