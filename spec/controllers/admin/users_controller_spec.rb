require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::UsersController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Admin::User.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Admin::User.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Admin::User.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_user_url(assigns[:user]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Admin::User.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Admin::User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Admin::User.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Admin::User.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Admin::User.first
    response.should redirect_to(admin_user_url(assigns[:user]))
  end

  it "destroy action should destroy model and redirect to index action" do
    user = Admin::User.first
    delete :destroy, :id => user
    response.should redirect_to(admin_users_url)
    Admin::User.exists?(user.id).should be_false
  end
end
