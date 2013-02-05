require 'spec_helper'

describe "matches/show" do
  before(:each) do
    @match = assign(:match, stub_model(Match,
      :homeTeam => "Home Team",
      :awayTeam => "Away Team",
      :pitch => 1,
      :umpire => "Umpire"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Home Team/)
    rendered.should match(/Away Team/)
    rendered.should match(/1/)
    rendered.should match(/Umpire/)
  end
end
