class AddColumnFinishTimeToHeatHurdlesTable < ActiveRecord::Migration
  def up
    add_column :heat_hurdles, :finish_time, :time
  end

  def down
    remove_column :heat_hurdles, :finish_time
  end
end
