def full_title(page_title)
  base_title = "Heriot-Watt Sports Tournament"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def sign_in_staff(staff)
  visit staff_signin_path
  fill_in "Username",    with: staff.user_name
  fill_in "Password", with: staff.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = staff.remember_token
end 
	
