require 'spec_helper'

describe Admin::DashboardController do
	describe "GET 'index'" do
		sign_in_staff FactoryGirl.create(:staff)
		it "returns http success" do
	     	 get 'index'
	      	response.should be_success
		end
	end
end
