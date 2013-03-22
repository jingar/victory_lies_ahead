class PointsAndGoaldifToTeams < ActiveRecord::Migration
  def up
      add_column :teams, :points, :integer, :default => 0
      add_column :teams, :goalsdif, :integer, :default => 0
  end
  def down
    remove_column :teams, :points, :default => nil
    remove_column :teams, :goalsdif, :default => nil_
  end
end
