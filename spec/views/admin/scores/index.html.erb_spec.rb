require 'spec_helper'

describe "admin/scores/index" do
  before(:each) do
    assign(:admin_scores, [
      stub_model(Admin::Score,
        :amount => 1,
        :matches_id => 2,
        :wattball_id => 3
      ),
      stub_model(Admin::Score,
        :amount => 1,
        :matches_id => 2,
        :wattball_id => 3
      )
    ])
  end

  it "renders a list of admin/scores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
