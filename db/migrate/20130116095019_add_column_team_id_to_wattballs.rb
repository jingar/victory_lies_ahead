class AddColumnTeamIdToWattballs < ActiveRecord::Migration
  def change
    add_column :wattballs, :team_id, :integer
  end
end
