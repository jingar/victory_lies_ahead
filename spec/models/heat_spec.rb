# == Schema Information
#
# Table name: heats
#
#  id            :integer          not null, primary key
#  gender        :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  time          :datetime
#  round         :integer
#  tournament_id :integer
#  played        :boolean          default(FALSE)
#

require 'spec_helper'

describe Heat do
  let(:found_heat) { Heat.find_by_time(@heat.time) }
    before do
      @heat = Heat.new(time: "01/04/2013 14:00:00", gender: "m")
    end

  subject { @heat }

  it { should respond_to(:time) }
  it { should respond_to(:gender) }

  it { should be_valid }

  describe "when time is not present" do
    before { @heat.time = " " }
    it { should_not be_valid }
  end

  describe "when gender is not present" do
    before { @heat.gender = " " }
    it { should_not be_valid }
  end

  describe "when gender is too long" do
    before { @heat.gender = "a" * 2 }
    it { should_not be_valid }
  end
end
