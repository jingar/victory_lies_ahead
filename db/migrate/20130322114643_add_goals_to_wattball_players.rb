class AddGoalsToWattballPlayers < ActiveRecord::Migration
  def up
      add_column :wattballs, :goals, :integer, :default => 0
  end
  def down
    remove_column :wattballs, :goals, :default => nil
  end
end
