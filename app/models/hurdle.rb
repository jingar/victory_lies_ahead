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
  attr_accessible :first_name, :last_name, :qualification, :gender

  belongs_to :user
  has_many :heats, through: :heat_hurdles

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true, length: {maximum: 1} 

  def name
    "#{first_name}. #{last_name}"
  end
end
