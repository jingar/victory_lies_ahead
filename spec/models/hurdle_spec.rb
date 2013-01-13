# == Schema Information
#
# Table name: hurdles
#
#  id            :integer          not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  qualification :datetime 
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#

require 'spec_helper'

describe Hurdle do
    let(:found_athlete) { Hurdle.find_by_first_name(@althlete.first_name) }
    before do
      @athlete = Hurdle.new(id: "1", first_name: "Example", last_name: "User", qualification: "13:25:58")
    end

  subject { @athlete }

  it { should respond_to(:id) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:qualification) }

  it { should be_valid }

  describe "when first name is not present" do
    before { @athlete.first_name = " " }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
    before { @athlete.last_name = " " }
    it { should_not be_valid }
  end

end
