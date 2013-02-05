# == Schema Information
#
# Table name: heat_hurdles
#
#  id         :integer          not null, primary key
#  heat_id    :integer
#  hurdle_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class HeatHurdle < ActiveRecord::Base
  belongs_to :heat
  belongs_to :hurdle

  validates :hurdle_id, presence: true
  validates :heat_id, presence: true
end