require 'spec_helper'

describe HeatsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, id: Heat.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model us invalid" do
    Heat.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Heat.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(heats_url(assigns[:heat]))
  end

  it "edit action should render edit template" do
    get :edit, id: Heat.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Heat.any_instance.stubs(:valid?).returns(false)
    put :update, id: Heat.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Heat.any_instance.stubs(:valid?).returns(true)
    put :update, id: Heat.first
    responce.should redirect_to(heats_url(assigns[:heat]))
  end

  it "destroy action should destroy model and redirect to index action" do
    heat = Heat.first
    delete :destroy, id: heat
    response.should redirect_to(heats_url)
    Heat.exists?(heat.id).should be_false
  end
end
