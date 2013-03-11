# == Schema Information
#
# Table name: teams
#
#  id                :integer          not null, primary key
#  team_name         :string(255)
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  match_teams_id    :integer
#  wins              :integer          default(0)
#  draws             :integer          default(0)
#  losses            :integer          default(0)
#  goalsfor          :integer          default(0)
#  goalsagainst      :integer          default(0)
#  number_of_players :integer
#

require 'spec_helper'

describe Team do
  let(:user) { FactoryGirl.create(:user) }
    let(:found_team) { Team.find_by_team_name(@team.team_name) }
    before do
      @team = user.teams.build(team_name: "FC Zenit")
    end

  subject { @team }

  it { should respond_to(:team_name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) {should == user}

  it { should be_valid }

  describe "when team name is not present" do
    before { @team.team_name = " " }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Team.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
