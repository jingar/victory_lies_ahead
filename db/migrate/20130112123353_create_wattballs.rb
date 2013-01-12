class CreateWattballs < ActiveRecord::Migration
  def change
    create_table :wattballs do |t|
      t.string :team_name
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
