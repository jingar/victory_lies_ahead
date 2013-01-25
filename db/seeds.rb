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
