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
end
