# == Schema Information
#
# Table name: heat_hurdles
#
#  id          :integer          not null, primary key
#  heat_id     :integer
#  hurdle_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  finish_time :time
#

class HeatHurdle < ActiveRecord::Base
  attr_accessible :hurdle_id, :heat_id, :finish_time

  belongs_to :heat
  belongs_to :hurdle

  validates :hurdle_id, presence: true
end
