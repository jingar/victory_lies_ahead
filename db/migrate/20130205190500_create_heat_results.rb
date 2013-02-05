class CreateHeatResults < ActiveRecord::Migration
  def change
    create_table :heat_results do |t|
      t.time :result_time
      t.references :heat
      t.references :hurdle

      t.timestamps
    end
    add_index :heat_results, :heat_id
    add_index :heat_results, :hurdle_id
  end
end
