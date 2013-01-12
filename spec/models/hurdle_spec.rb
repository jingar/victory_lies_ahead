require 'spec_helper'

describe Hurdle do
    let(:found_athlete) { Hurdle.find_by_first_name(@althlete.first_name) }
    before do
	@althlete = Hurdle.new(first_name: "Example", last_name: "User", qualification: '00:10:54')
    end

  subject { @athlete }

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
