class AddColumnLaneToHeatHurdlesTable < ActiveRecord::Migration
  def up
    add_column :heat_hurdles, :lane, :integer
  end

  def down
    remove_column :heat_hurdles, :lane
  end
end
