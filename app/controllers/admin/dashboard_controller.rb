class Admin::DashboardController < ApplicationController
	before_filter :signed_in_staff, only: [:index]
  def index
  end
end
