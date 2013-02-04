class AddColumnMatchTeamsIdToTeamsTable < ActiveRecord::Migration
  def up
    add_column :teams, :match_teams_id, :integer
  end

  def down
    remove_column :teams, :match_teams_id
  end
end
