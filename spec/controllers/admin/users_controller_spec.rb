require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::UsersController do
  fixtures :all
  render_views

  before do
    sign_in_staff FactoryGirl.create(:staff)

  end
  
  let(:user) { FactoryGirl.create(:user) }
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, id: user.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_user_url(assigns[:user]))
  end

  it "edit action should render edit template" do
    get :edit, id: user.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    put :update, id: user.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(true)
    put :update, id: user.id
    response.should redirect_to(admin_user_url(assigns[:user]))
  end

  it "destroy action should destroy model and redirect to index action" do
    user_t = user.first
    delete :destroy, :id => user_t
    response.should redirect_to(admin_users_url)
    user_t.exists?(user_t.id).should be_false
  end
end
