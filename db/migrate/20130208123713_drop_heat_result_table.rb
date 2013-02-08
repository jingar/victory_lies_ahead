class DropHeatResultTable < ActiveRecord::Migration
  def change
    drop_table :heat_results
  end
end
