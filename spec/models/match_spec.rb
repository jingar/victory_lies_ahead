# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  when       :datetime
#  homeTeam   :string(255)
#  awayTeam   :string(255)
#  pitch      :integer
#  umpire     :string(255)
#  homeGoals  :integer
#  awayGoals  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Match do
  pending "add some examples to (or delete) #{__FILE__}"
end
