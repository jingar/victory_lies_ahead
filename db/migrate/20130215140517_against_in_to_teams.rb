class AgainstInToTeams < ActiveRecord::Migration
  def up
  	add_column :teams, :goalsfor, :integer, :default =>0
  	add_column :teams, :goalsagainst, :integer, :default =>0
  end

  def down
  	remove_column :teams, :goalsfor, :default =>nil
  	remove_column :teams, :goalsagainst, :default =>nil
  end
end
