class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  include SessionsHelper
  include StaffSessionsHelper
  
	def skip_header
		@header = true;
	end
end
