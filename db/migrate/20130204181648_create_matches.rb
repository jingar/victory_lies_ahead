class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :when
      t.integer :homeTeam
      t.integer :awayTeam
      t.integer :pitch
      t.string :umpire
      t.integer :homeGoals
      t.integer :awayGoals
      t.references :team_id

      t.timestamps
    end
  end
end
