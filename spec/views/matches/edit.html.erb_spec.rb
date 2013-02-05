require 'spec_helper'

describe "matches/edit" do
  before(:each) do
    @match = assign(:match, stub_model(Match,
      :homeTeam => "MyString",
      :awayTeam => "MyString",
      :pitch => 1,
      :umpire => "MyString"
    ))
  end

  it "renders the edit match form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => matches_path(@match), :method => "post" do
      assert_select "input#match_homeTeam", :name => "match[homeTeam]"
      assert_select "input#match_awayTeam", :name => "match[awayTeam]"
      assert_select "input#match_pitch", :name => "match[pitch]"
      assert_select "input#match_umpire", :name => "match[umpire]"
    end
  end
end
