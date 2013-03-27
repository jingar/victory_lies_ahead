class AddAdminAndTournamentToDb < ActiveRecord::Migration
  def change
  	Staff.create({ first_name: "head", last_name: "organiser", position: "Admin", user_name: "head_organiser", password: "organise", password_confirmation: "organise" })
  	Tournament.create!(name: "Riccarton Sports Tournament", start_date: DateTime.now + 10.days, end_date: DateTime.now + 18.days)
  end
end
