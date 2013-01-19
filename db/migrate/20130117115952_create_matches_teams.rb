class CreateMatchesTeams < ActiveRecord::Migration
    def change
	create_table :matches_teams do |t|
	    t.references :team
	    t.references :match

	    t.timestamps
	end
    
	add_index :matches_teams, :team_id
	add_index :matches_teams, :match_id
    end
end
