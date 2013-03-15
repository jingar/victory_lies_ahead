# == Schema Information
#
# Table name: tickets
#
#  id                        :integer          not null, primary key
#  first_name                :string(255)
#  last_name                 :string(255)
#  email                     :string(255)
#  address                   :string(255)
#  order_id                  :string(255)
#  adult_tickets_bought      :integer
#  concession_tickets_bought :integer
#  used                      :boolean          default(FALSE)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

require 'spec_helper'

describe Ticket do
  pending "add some examples to (or delete) #{__FILE__}"
end
