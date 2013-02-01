FactoryGirl.define do
	factory :user do
		first_name	"Saad"
		last_name "Arif"
		email	"saadarif006@gmail.com"
		address "125 baker street"
		telephone "12121212112"
		password	"foobar"
		password_confirmation	"foobar"
		sport	"wattball"
	end
	factory :staff do
		first_name "Saad"
		last_name "Arif"
		user_name "saad_arif"
		password "123456"
		password_confirmation "123456"
		position "Admin"
	end
end