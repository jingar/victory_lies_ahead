require 'spec_helper'

describe Admin::UsersController do
  fixtures :all
  render_views

  before(:each) do
    sign_in_staff FactoryGirl.create(:staff)
  end
  let(:user) { FactoryGirl.create(:user) }

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
      get :show, id: user
      assigns(:user).should eq(user)
    end

    it "show action should render show template" do
      get :show, id: user
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
      post :create, user: FactoryGirl.attributes_for(:user)
      response.should redirect_to (admin_users_path)
    end
  end

  it "edit action should render edit template" do
    get :edit, id: user
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
     @user = FactoryGirl.create(:user, first_name: "Test", last_name: "Best", email: "Tbest@example.com",
        address: "blah blah 1", telephone: "121212", sport:"hurdles")
    User.any_instance.stubs(:valid?).returns(false)
    put :update, id: @user, user: FactoryGirl.attributes_for(:user)
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(true)
    put :update, id: user
    response.should redirect_to(admin_user_url(assigns[:user]))
  end

  it "destroy action should destroy model and redirect to index action" do
    user = FactoryGirl.create(:user)
    delete :destroy, :id => user
    response.should redirect_to(admin_users_url)
    User.exists?(user.id).should be_false
  end
end
