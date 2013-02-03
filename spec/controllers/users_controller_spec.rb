require 'spec_helper'

describe Admin::UsersController do
  fixtures :all
  render_views

  before do
    sign_in_staff FactoryGirl.create(:staff)
  end

  describe "GET #index" do
    it "populate an array of users" do 
      user = FactoryGirl.create(:user)
      get:index
      assigns(:users).should eq([user])
    end

    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested user to @user" do
      user = FactoryGirl.create(:user)
      get :show, id: user
      assigns(:user).should eq(user)
    end

    it "show action should render show template" do
      user = 
      get :show, id: FactoryGirl.create(:user)
      response.should render_template(:show)
    end
  end

    it "new action should render new template" do
      get :new
      response.should render_template(:new)
    end
  describe "POST create" do
    it "create action should render new template when model is invalid" do
      User.any_instance.stubs(:valid?).returns(false)
      post :create
      response.should render_template(:new)
    end

    it "create action should redirect when model is valid" do
      User.any_instance.stubs(:valid?).returns(true)
      post :create 
      response.should redirect_to (admin_users_path)
    end
  end

  it "edit action should render edit template" do
    get :edit, id: FactoryGirl.create(:user)
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    put :update, id: 
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    ::User.any_instance.stubs(:valid?).returns(true)
    put :update, id: FactoryGirl.create(:user)
    response.should redirect_to(admin_user_url(assigns[:user]))
  end

  it "destroy action should destroy model and redirect to index action" do
    user = FactoryGirl.create(:user)
    delete :destroy, :id => user
    response.should redirect_to(admin_users_url)
    User.exists?(user.id).should be_false
  end
end
