# == Schema Information
#
# Table name: umpires
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  umpire_id  :integer
#

require 'spec_helper'

describe Umpire do
  pending "add some examples to (or delete) #{__FILE__}"
end
