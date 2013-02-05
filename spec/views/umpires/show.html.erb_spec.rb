require 'spec_helper'

describe "umpires/show" do
  before(:each) do
    @umpire = assign(:umpire, stub_model(Umpire,
      :first_name => "First Name",
      :last_name => "Last Name",
      :email => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(//)
  end
end
