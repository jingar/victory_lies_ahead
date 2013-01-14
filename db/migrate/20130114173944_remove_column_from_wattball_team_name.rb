class RemoveColumnFromWattballTeamName < ActiveRecord::Migration
    def up
	remove_column :wattballs, :team_name
    end

    def down
	add_column :wattballs, :team_name, :string
    end
end
