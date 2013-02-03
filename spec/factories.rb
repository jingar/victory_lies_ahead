FactoryGirl.define do
  factory :user do
    first_name "Saad"
    last_name "Arif"
    email "saadarif@gmail.com"
    address "125 baker street"
    telephone "12121212112"
    password "foobar"
    password_confirmation "foobar"
    sport "wattball"
  end

  factory :invalid_user, parent: :user do |f|
    f.first_name nil
  end

  factory :staff do
    first_name "Saad"
    last_name "Arif"
    user_name "saad_arif"
    password "123456"
    password_confirmation "123456"
    position "Admin"
  end

  factory :heat do
    time "01/04/2013 12:00:00"
    gender "m"
  end

  factory :team do
    team_name "Zenit"
    user
  end

  factory :player do
    first_name "Scott"
    last_name "Logic"
    team
  end
end
