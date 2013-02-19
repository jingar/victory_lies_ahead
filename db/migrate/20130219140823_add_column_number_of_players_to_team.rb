class AddColumnNumberOfPlayersToTeam < ActiveRecord::Migration
  def up
      add_column :teams, :number_of_players, :integer
  end
  def down
    remove_column :teams, :number_of_players
  end
end
