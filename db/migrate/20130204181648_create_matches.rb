class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :when
      t.string :homeTeam
      t.string :awayTeam
      t.integer :pitch
      t.string :umpire
      t.integer :homeGoals
      t.integer :awayGoals

      t.timestamps
    end
  end
end
