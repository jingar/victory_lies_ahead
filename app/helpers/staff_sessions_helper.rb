module StaffSessionsHelper
	def sign_in_staff(staff)
		cookies.permanent[:remember_token] = staff.remember_token
		self.current_user_staff = staff
	end

	def signed_in_staff?
		!current_user_staff.nil?
	end

	def current_user_staff= (staff)
		@current_user_staff = staff
	end

	def current_user_staff
		@current_user_staff ||= Staff.find_by_remember_token(cookies[:remember_token])
	end

	def current_user_staff?(user)
		user == current_user_staff(Staff)
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
        
        def signed_in_staff
          unless signed_in_staff?
            store_location_staff
            redirect_to '/admin/staffsignin', notice: "Please sign in."
          end
        end
        def is_staff?
          @staff_level = Staff.find_by_remember_token(cookies[:remember_token])
          @staff_level.position == "Staff"
        end

        def is_admin?
          @staff_level = Staff.find_by_remember_token(cookies[:remember_token])
          @staff_level.position == "Admin"
        end
        def staff_access
          if !is_staff?
            redirect_to('/404.html')
          end
        end

        def admin_access
          if !is_admin?
            redirect_to('/404.html')
          end
        end
end
