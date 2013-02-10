# == Schema Information
#
# Table name: tournaments
#
#  id         :integer          not null, primary key
#  start_date :datetime
#  end_date   :datetime
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Tournament do
  pending "add some examples to (or delete) #{__FILE__}"
end
