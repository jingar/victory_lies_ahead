require 'spec_helper'

describe "admin/scores/edit" do
  before(:each) do
    @admin_score = assign(:admin_score, stub_model(Admin::Score,
      :amount => 1,
      :matches_id => 1,
      :wattball_id => 1
    ))
  end

  it "renders the edit admin_score form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_scores_path(@admin_score), :method => "post" do
      assert_select "input#admin_score_amount", :name => "admin_score[amount]"
      assert_select "input#admin_score_matches_id", :name => "admin_score[matches_id]"
      assert_select "input#admin_score_wattball_id", :name => "admin_score[wattball_id]"
    end
  end
end
