FactoryGirl.define do
  factory :user do |u|
    u.first_name "Saad"
    u.last_name "Arif"
    u.email Faker::Internet.email#"saadarif@gmail.com"
    u.address "125 baker street"
    u.telephone "12121212112"
    u.password "foobar"
    u.password_confirmation "foobar"
    u.sport "wattball"
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

  factory :team do |t|
    user
    t.team_name Faker::Name.first_name
  end

  factory :invalid_team, parent: :team do |t|
    t.team_name nil
  end

  factory :player do
    team
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end
end
