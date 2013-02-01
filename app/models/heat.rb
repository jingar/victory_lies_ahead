# == Schema Information
#
# Table name: heats
#
#  id         :integer          not null, primary key
#  gender     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  time       :datetime
#

class Heat < ActiveRecord::Base
  attr_accessible :gender, :time

  has_many :hurdles, through: :heat_hurdles

  validates :gender, presence: true, length: { maximum: 1 }
  validates :time, presence: true
end
