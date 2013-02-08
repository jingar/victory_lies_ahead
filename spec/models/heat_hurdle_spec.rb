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

require 'spec_helper'

describe HeatHurdle do
  pending "add some examples to (or delete) #{__FILE__}"
end
