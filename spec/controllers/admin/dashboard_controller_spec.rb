require 'spec_helper'

describe Admin::DashboardController do
	describe "GET 'index'" do
		let(:staff) { FactoryGirl.create(:staff) }
    	sign_in_staff(staff)
    	it "returns http success" do
	     	 get 'index'
	      	response.should be_success
		end
	end
end
