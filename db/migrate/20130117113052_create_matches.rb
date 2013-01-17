class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :when
      t.references :umpire

      t.timestamps
    end
    add_index :matches, :umpire_id
  end
end
