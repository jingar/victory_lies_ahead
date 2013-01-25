class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :when
      t.string :opponent
      t.integer :pitch
      t.references :umpire

      t.timestamps
    end
    add_index :matches, :umpire_id
  end
end
