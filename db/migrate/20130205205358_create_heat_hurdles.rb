class CreateHeatHurdles < ActiveRecord::Migration
  def change
    create_table :heat_hurdles do |t|
      t.references :heat
      t.references :hurdle

      t.timestamps
    end
    add_index :heat_hurdles, :heat_id
    add_index :heat_hurdles, :hurdle_id
  end
end
