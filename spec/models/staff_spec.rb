# == Schema Information
#
# Table name: staffs
#
#  id                    :integer          not null, primary key
#  first_name            :string(255)
#  last_name             :string(255)
#  password              :string(255)
#  password_confirmation :string(255)
#  type                  :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_name             :string(255)
#

require 'spec_helper'

describe Staff do
  pending "add some examples to (or delete) #{__FILE__}"
end
