require 'spec_helper'

describe "admin/scores/new" do
  before(:each) do
    assign(:admin_score, stub_model(Admin::Score,
      :amount => 1,
      :matches_id => 1,
      :wattball_id => 1
    ).as_new_record)
  end

  it "renders new admin_score form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_scores_path, :method => "post" do
      assert_select "input#admin_score_amount", :name => "admin_score[amount]"
      assert_select "input#admin_score_matches_id", :name => "admin_score[matches_id]"
      assert_select "input#admin_score_wattball_id", :name => "admin_score[wattball_id]"
    end
  end
end
