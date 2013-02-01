class RenameMatchTeams < ActiveRecord::Migration
  def up
    drop_table :matches_teams

    create_table :match_teams do |t|
      t.references :team
      t.references :match

      t.timestamps
    end
    
    add_index :match_teams, :team_id
    add_index :match_teams, :match_id
  end

  def down
    drop_table :match_teams
  end
end
