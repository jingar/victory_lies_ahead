class AddColumnRoundToHeatsTable < ActiveRecord::Migration
  def up
    add_column :heats, :round, :integer
  end

  def down
    remove_column :heats, :round
  end
end
