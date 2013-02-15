class AddingWinsLossesDrawsToTeansTable < ActiveRecord::Migration
  def up
  	add_column :teams, :wins, :integer, :default =>0
  	add_column :teams, :draws, :integer, :default =>0
  	add_column :teams, :losses, :integer, :default =>0
  end

  def down
  	remove_column :teams, :wins, :default =>nil
  	remove_column :teams, :draws, :default =>nil
  	remove_column :teams, :losses, :default =>nil
  end
end
