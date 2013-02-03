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
  { first_name: "Saad", last_name: "Arif", email: "saadarif006@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "hurdles"},
  { first_name: "Alex", last_name: "Eldridge", email: "alexeldridge@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "hurdles"},
  { first_name: "Graham", last_name: "MacDonald", email: "gmacdonald95656@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "hurdles"},
  { first_name: "John", last_name: "Stainsby", email: "johnstainsby@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "wattball"},
  { first_name: "Nikola", last_name: "Damaskov", email: "mamatakolio@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "wattball"},
  { first_name: "Robbie", last_name: "Henderson", email: "robbie.gavin.henderson@gmail.com", address: "Edinburgh", telephone: "+44", password: "123456", password_confirmation: "123456", sport: "hurdle"}
]) 

hurdleSaad = User.find(2).hurdles.create!(first_name: "Saad", last_name: "Arif", gender: "m", qualification: "00:00:50")
hurdleAlex = User.find(3).hurdles.create(first_name: "Alex", last_name: "Eldrige", gender: "m", qualification: "0):01:30")
 hurdleAlex = User.find(4).hurdles.create(first_name: "Graham", last_name: "MacDonald", gender: "m", qualification: "00:00:00")
 hurdleAlex = User.find(7).hurdles.create(first_name: "Robbie", last_name: "Henderson", gender: "m", qualification: "00:01:10")

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
], without_protection: true)

heats = Heat.create!([
  {time: "01/04/2013 12:00:00", gender: "m"},
  {time: "01/04/2013 12:30:00", gender: "f"}
])
