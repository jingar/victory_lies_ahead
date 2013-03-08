# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
staff = Staff.create({ first_name: "head", last_name: "organiser", position: "head organiser", user_name: "head_organiser", password: "organise", password_confirmation: "organise" })

# representative data for demonstrations
reps = User.create!([
  { first_name: "Konstantin", last_name: "Devyatov", email: "kdnalus@gmail.com", address: "2F2 65 York place, Edinburgh, EH1 3JD", telephone: "07500626389", password: "123456", password_confirmation: "123456", sport: "wattball"},
  { first_name: "Saad", last_name: "Arif", email: "saadarif007@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "hurdles"},
  { first_name: "Alex", last_name: "Eldridge", email: "alexeldridge@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "hurdles"},
  { first_name: "Graham", last_name: "MacDonald", email: "gmacdonald95656@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "hurdles"},
  { first_name: "John", last_name: "Stainsby", email: "johnstainsby@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "wattball"},
  { first_name: "Nikola", last_name: "Damaskov", email: "mamatakolio@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "wattball"},
  { first_name: "Robbie", last_name: "Henderson", email: "robbie.gavin.henderson@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "hurdle"}
])
# 4 dev team participants
User.find(2).hurdles.create!(first_name: "Saad", last_name: "Arif", gender: "m", qualification: "00:00:50", round: 1)
User.find(3).hurdles.create(first_name: "Alex", last_name: "Eldrige", gender: "m", qualification: "00:01:30", round: 1)
User.find(4).hurdles.create(first_name: "Graham", last_name: "MacDonald", gender: "m", qualification: "00:00:00", round: 1)
User.find(7).hurdles.create(first_name: "Robbie", last_name: "Henderson", gender: "m", qualification: "00:01:10", round: 1)
# 25 males with no qualification
for i in 1..25 do
  User.find(2).hurdles.create!(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, gender: "m", qualification: "00:00:00", round: 0)
end
# 25 males with valid qualification
for i in 1..25 do
  User.find(3).hurdles.create!(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, gender: "m", qualification: "00:#{rand(0..5)}:#{rand(0..59)}", round: 1)
end
# 25 female with no qualification
for i in 1..25 do
  User.find(2).hurdles.create!(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, gender: "f", qualification: "00:00:00", round: 0)
end
# 25 female with valid qualification
for i in 1..25 do
  User.find(3).hurdles.create!(first_name: Faker::Name::first_name, last_name: Faker::Name::last_name, gender: "f", qualification: "00:#{rand(0..5)}:#{rand(0..59)}", round: 1)
end
hurdles = Hurdle.all
# 3 Teams
teamKos = User.find(1).teams.create!(team_name: "Heriot-Watt brigade").wattballs.create!([
  {first_name: "Emily", last_name: "Harvard"},
  {first_name: "David", last_name: "Borland"},
  {first_name: "Harry", last_name: "Watt"},
  {first_name: "Maureen", last_name: "Young"},
  {first_name: "Jacklyn", last_name: "Prindergasd"},
  {first_name: "Joanne", last_name: "Glidewell"},
  {first_name: "Paul", last_name: "Page"},
  {first_name: "Milady", last_name: "Scarborough"},
  {first_name: "Ronald", last_name: "Arwood"},
  {first_name: "Bill", last_name: "Canty"},
  {first_name: "Jonathan", last_name: "Aule"}
], without_protection: true)

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

tournament = Tournament.create!(name: "Riccarton Sports Tournament", start_date: "01/04/2013 08:15:00", end_date: "08/04/2013 22:30:00")

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
#heat = Heat.create!(gender: "m", time: "01/04/2013 16:00:00")
#hurdles.each { |h| heat.hurdles << h }
