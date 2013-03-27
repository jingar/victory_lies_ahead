
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# representative data for demonstrations
reps = User.create!([
  { first_name: "Konstantin", last_name: "Devyatov", email: "kdnalus@gmail.com", address: "2F2 65 York place, Edinburgh, EH1 3JD", telephone: "07500626389", password: "123456", password_confirmation: "123456", sport: "wattball"},
  { first_name: "Saad", last_name: "Arif", email: "saadarif009@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "hurdles"},
  { first_name: "Alex", last_name: "Eldridge", email: "alexeldridge@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "hurdles"},
  { first_name: "Graham", last_name: "MacDonald", email: "gmacdonald95656@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "hurdles"},
  { first_name: "John", last_name: "Stainsby", email: "saadarif006@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "wattball"},
  { first_name: "Nikola", last_name: "Damaskov", email: "saadarif002@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "wattball"},
  { first_name: "Robbie", last_name: "Henderson", email: "robbie.gavin.henderson@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "wattball"}
])
# 4 dev team participants
User.find(2).hurdles.create!(first_name: "Saad", last_name: "Arif", gender: "m", qualification: "00:00:50", round: 1)
User.find(3).hurdles.create(first_name: "Alex", last_name: "Eldrige", gender: "m", qualification: "00:01:30", round: 1)
User.find(4).hurdles.create(first_name: "Graham", last_name: "MacDonald", gender: "m", qualification: "00:00:00", round: 1)
User.find(7).hurdles.create(first_name: "Robbie", last_name: "Henderson", gender: "m", qualification: "00:01:10", round: 1)
# 25 males with no qualification
for i in 1..25 do
  User.create(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, email: Faker::Internet.email, address: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, password: "123456", password_confirmation: "123456", sport: "hurdles").hurdles.create!(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, gender: "m", qualification: "00:00:00", round: 0)
end
# 25 males with valid qualification
for i in 1..25 do
  User.create(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, email: Faker::Internet.email, address: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, password: "123456", password_confirmation: "123456", sport: "hurdles").hurdles.create!(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, gender: "m", qualification: "00:#{rand(0..5)}:#{rand(0..59)}", round: 1)
end
# 25 female with no qualification
for i in 1..25 do
  User.create(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, email: Faker::Internet.email, address: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, password: "123456", password_confirmation: "123456", sport: "hurdles").hurdles.create!(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, gender: "f", qualification: "00:00:00", round: 0)
end
# 25 female with valid qualification
for i in 1..25 do
  User.create(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, email: Faker::Internet.email, address: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, password: "123456", password_confirmation: "123456", sport: "hurdles").hurdles.create!(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, gender: "f", qualification: "00:#{rand(0..5)}:#{rand(0..59)}", round: 1)
end
hurdles = Hurdle.all
# 3 Teams
teamKos = User.create(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, email: "saadarif001@gmail.com", address: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, password: "123456", password_confirmation: "123456", sport: "wattball").teams.create(team_name: "WattBall Warriors").wattballs.create!([
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name}
])

teama = User.create(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, email: "saadarif003@gmail.com", address: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, password: "123456", password_confirmation: "123456", sport: "wattball").teams.create(team_name: "Athletico Wattballio").wattballs.create!([
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name}
])

teamb = User.create(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, email: "saadarif004@gmail.com", address: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, password: "123456", password_confirmation: "123456", sport: "wattball").teams.create(team_name: "AC Wattball").wattballs.create!([
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name}
])

teamc = User.create(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, email: "saadarif005@gmail.com", address: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, password: "123456", password_confirmation: "123456", sport: "wattball").teams.create(team_name: "WattBall Rovers").wattballs.create!([
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name}
])

teamd = User.create(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, email: "saadarif007@gmail.com", address: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, password: "123456", password_confirmation: "123456", sport: "wattball").teams.create(team_name: "Aligators of Doom").wattballs.create!([
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name},
  {first_name: Faker::Name::first_name, last_name: Faker::Name::last_name}
])

teamJohn = User.find(5).teams.create!(team_name: "Glasgolians").wattballs.create!([
  {first_name: "Earl", last_name: "Bash"},
  {first_name: "Jack", last_name: "Nall"},
  {first_name: "Ryan", last_name: "Robin"},
  {first_name: "Johnny", last_name: "Kidder"},
  {first_name: "Alisha", last_name: "Lamb"},
  {first_name: "Andrew", last_name: "Wigfall"},
  {first_name: "Stanly", last_name: "Sanderland"},
  {first_name: "Phillip", last_name: "Hitchcock"},
  {first_name: "Jonathan", last_name: "Stale"},
  {first_name: "Phillip", last_name: "Martins"},
  {first_name: "Amber", last_name: "Fisk"}
], without_protection: true)

teamNik = User.find(6).teams.create!(team_name: "Run or fight").wattballs.create!([
  {first_name: "Oliver", last_name: "Albaster"},
  {first_name: "Antonio", last_name: "Berks"},
  {first_name: "Peggy", last_name: "Oarth"},
  {first_name: "Bengamin", last_name: "Dupre"},
  {first_name: "Sharlyn", last_name: "Lian"},
  {first_name: "Bruce", last_name: "Kribbs"},
  {first_name: "Alan", last_name: "Cristian"},
  {first_name: "Joe", last_name: "Connel"},
  {first_name: "Harold", last_name: "Bilden"},
  {first_name: "Bobbie", last_name: "Fletcher"},
  {first_name: "John", last_name: "Hollinger"}
])

#11 Umpires
umpire = Umpire.create!([
  { first_name: "Alan", last_name: "Muir", email: "am245@gmail.com"},
  { first_name: "Calum", last_name: "Murray", email: "cm321@gmail.com"},
  { first_name: "Craig", last_name: "Thomson", email: "ct548@gmail.com"},
  { first_name: "Craig", last_name: "Charleston", email: "cc896@gmail.com"},
  { first_name: "Crawford", last_name: "Allan", email: "ca852@gmail.com"},
  { first_name: "Iain", last_name: "Brines", email: "ib666@gmail.com"},
  { first_name: "John", last_name: "McKendrick", email: "jm853@gmail.com"},
  { first_name: "Mike", last_name: "Tumilty", email: "mt025@gmail.com"},
  { first_name: "Paul", last_name: "Robertson", email: "pr556@gmail.com"},
  { first_name: "Stevie", last_name: "O'Reilly", email: "so007@gmail.com"},
  { first_name: "William", last_name: "Collum", email: "wc951@gmail.com"}
])

for i in 0..20 do 
  Ticket.create!(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, email: Faker::Internet.email,address: Faker::Address.city,adult_tickets_bought: rand(1..10), concession_tickets_bought: rand(1..10), used: "Not expired",ticket_date: DateTime.now + 7.day,ticket_type: "Reserved",order_id: "ad213fg" + rand(1000).to_s)
end 
#heat = Heat.create!(gender: "m", time: "01/04/2013 16:00:00")
#hurdles.each { |h| heat.hurdles << h }

