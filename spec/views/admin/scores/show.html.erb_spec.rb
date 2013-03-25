require 'spec_helper'

describe "admin/scores/show" do
  before(:each) do
    @admin_score = assign(:admin_score, stub_model(Admin::Score,
      :amount => 1,
      :matches_id => 2,
      :wattball_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
