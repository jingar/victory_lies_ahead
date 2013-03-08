# == Schema Information
#
# Table name: hurdles
#
#  id            :integer          not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  qualification :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  gender        :string(255)
#  round         :integer
#

require 'spec_helper'

describe Hurdle do
  let(:user) { FactoryGirl.create(:user) }
    let(:found_athlete) { Hurdle.find_by_first_name(@althlete.first_name) }
    before do
      @athlete = user.hurdles.build(first_name: "Example", last_name: "User", 
        qualification: "13:25:58", gender: "male")
    end

  subject { @athlete }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:qualification) }
  it { should respond_to(:gender) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) {should == user}

  it { should be_valid }

  describe "when first name is not present" do
    before { @athlete.first_name = " " }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
    before { @athlete.last_name = " " }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Hurdle.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
