class CreateMatchTeams < ActiveRecord::Migration
  def change
    create_table :match_teams do |t|
      t.references :team
      t.references :match

      t.timestamps
    end
    add_index :match_teams, :team_id
    add_index :match_teams, :match_id
  end
end
