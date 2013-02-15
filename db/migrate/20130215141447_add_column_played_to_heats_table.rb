class AddColumnPlayedToHeatsTable < ActiveRecord::Migration
  def up
    add_column :heats, :played, :boolean, :default => true
  end

  def down
    remove_column :heats, :played, :default => nil
  end
end
