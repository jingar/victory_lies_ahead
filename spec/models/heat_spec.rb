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

require 'spec_helper'

describe Heat do
  let(:found_heat) { Heat.find_by_when(@heat.when) }
    before do
      @heat = Heat.new(when: "01/04/2013 14:00:00", gender: "m")
    end

  subject { @heat }

  it { should respond_to(:when) }
  it { should respond_to(:gender) }

  it { should be_valid }

  describe "when is not present" do
    before { @heat.when = " " }
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
