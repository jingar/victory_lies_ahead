class CreateHurdles < ActiveRecord::Migration
  def change
    create_table :hurdles do |t|
      t.string :first_name
      t.string :last_name
      t.time :qualification

      t.timestamps
    end
  end
end
