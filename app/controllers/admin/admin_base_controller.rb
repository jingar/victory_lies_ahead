class Admin::AdminBaseController < ApplicationController
	before_filter :signed_in_staff
	before_filter :skip_header	
end