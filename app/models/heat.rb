# == Schema Information
#
# Table name: heats
#
#  id            :integer          not null, primary key
#  gender        :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  time          :datetime
#  round         :integer
#  tournament_id :integer
#  played        :boolean          default(FALSE)
#

class Heat < ActiveRecord::Base
  attr_accessible :gender, :time, :hurdles_attributes, :heat_hurdles_attributes, :tournament_id, :round, :played

  has_many :hurdles, through: :heat_hurdles
  has_many :heat_hurdles, :dependent => :destroy
  belongs_to :tournament
  accepts_nested_attributes_for :heat_hurdles

  scope :rounded_heats, order('round ASC')

  validates :gender, presence: true, length: { maximum: 1 }
  validates :time, presence: true
  validates_uniqueness_of :time
end
