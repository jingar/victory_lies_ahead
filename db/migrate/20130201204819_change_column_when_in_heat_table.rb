class ChangeColumnWhenInHeatTable < ActiveRecord::Migration
  def up
    add_column :heats, :time, :datetime
    remove_column :heats, :when
  end

  def down
    remove_column :heats, :time
    add_column :heats, :when, :datetime
  end
end
