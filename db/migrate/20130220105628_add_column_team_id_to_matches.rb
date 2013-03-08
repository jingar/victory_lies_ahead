class AddColumnTeamIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :team_id, :integer
  end
end
