require 'spec_helper'

describe "umpires/index" do
  before(:each) do
    assign(:umpires, [
      stub_model(Umpire,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => ""
      ),
      stub_model(Umpire,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => ""
      )
    ])
  end

  it "renders a list of umpires" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
