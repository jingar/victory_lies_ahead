module Admin::StaffSessionsHelper
	def sign_in_staff(staff)
		cookies.permanent[:remember_token] = staff.remember_token
		self.current_staff = staff
	end

	def signed_in_staff?
		!current_staff.nil?
	end

	def current_user_staff= (staff)
		@current_staff = staff
	end

	def current_user_staff
		@current_staff ||= Staff.find_by_remember_token(cookies[:remember_token])
	end

	def current_user_staff?(user)
		user == current_staff(Staff)
	end

	def sign_out_staff
		self.current_staff = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or_staff(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location_staff
		session[:return_to] = request.url
	end
end
