# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
staff = Staff.create({ first_name: "head", last_name: "organiser", position: "head organiser", user_name: "head_organiser", password: "organise", password_confirmation: "organise" })
