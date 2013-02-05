require 'spec_helper'

describe TeamsController do
  fixtures :all
  render_views

  #user = FactoryGirl.create(:user)
  team = FactoryGirl.create(:team)#, user_id: user.id)

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, id: team.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model us invalid" do
    Team.any_instance.stubs(:valid?).returns(false)
    post :create 
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Team.any_instance.stubs(:valid?).returns(true)
    post :create, team: FactoryGirl.attributes_for(:team)
    response.should redirect_to(teams_url)
  end

  it "edit action should render edit template" do
    get :edit, id: team.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    #@team = FactoryGirl.build(:team, team_name: "Bubbah")
    Team.any_instance.stubs(:valid?).returns(false)
    put :update, id: team.id, team: FactoryGirl.attributes_for(:invalid_team)
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Team.any_instance.stubs(:valid?).returns(true)
    put :update, id: team.id
    response.should redirect_to(team)
  end

  it "delete action should destroy model and redirect to index action" do
    delete :destroy, id: team.id
    response.should redirect_to(teams_url)
    Team.exists?(team.id).should be_false
  end
end
