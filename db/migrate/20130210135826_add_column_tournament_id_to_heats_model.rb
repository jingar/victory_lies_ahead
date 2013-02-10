class AddColumnTournamentIdToHeatsModel < ActiveRecord::Migration
  def up
    add_column :heats, :tournament_id, :integer
  end

  def down
    column_remove :heats, :tournament_id
  end
end
