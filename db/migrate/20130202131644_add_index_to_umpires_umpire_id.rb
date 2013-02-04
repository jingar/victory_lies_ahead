class AddIndexToUmpiresUmpireId < ActiveRecord::Migration
  def change
  add_index :umpires, :umpire_id, unique: true
  end
end
