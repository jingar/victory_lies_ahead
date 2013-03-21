class AddTournamentIdToMatches < ActiveRecord::Migration
  def up
    add_column :matches, :tournament_id, :integer
  end

  def down
    remove_column :matches, :tournament_id
  end
end
