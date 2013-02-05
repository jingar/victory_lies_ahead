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

require 'spec_helper'

describe HeatResult do
  pending "add some examples to (or delete) #{__FILE__}"
end
