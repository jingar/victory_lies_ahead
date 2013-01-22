class Admin::DashboardController < ApplicationController
	before_filter :signed_in_staff, only: [:index]
	before_filter :skip_header
  def index
  end
end
