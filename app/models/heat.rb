# == Schema Information
#
# Table name: heats
#
#  id         :integer          not null, primary key
#  when       :datetime
#  gender     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Heat < ActiveRecord::Base
  attr_accessible :gender, :when

  has_many :hurdles, through: :heat_hurdles

  validates :gender, presence: true, length: { maximum: 1 }
  validates :when, presence: true
end
