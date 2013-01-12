namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(first_name: "Example",
                  last_name: "User",
                 email: "example@railstutorial.org",
                 address: "122Backe",
                 telephone: "01021212",
                 sport: "hurdles",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      first_name  = Faker::Name.first_name
      last_name  = Faker::Last_name.last_name
      email = "example-#{n+1}@railstutorial.org"
      address = Faker::Address.street_address
      telephone = Faker::PhoneNumber.telephone
      sport = "hurdles"
      password  = "password"
      User.create!(first_name: first_name,
                   last_name: last_name,
                   address: address,
                   telephone: telephone,
                   sport: sport,
                   password: password,
                   password_confirmation: password)
    end
  end
end