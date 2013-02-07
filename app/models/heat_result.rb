# == Schema Information
#
# Table name: heat_results
#
#  id          :integer          not null, primary key
#  result_time :time
#  heat_id     :integer
#  hurdle_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class HeatResult < ActiveRecord::Base
  attr_accessible :result_time, :heat_id, :hurdle_id

  belongs_to :heat
  belongs_to :hurdle

  validates :result_time, presence: true
end
