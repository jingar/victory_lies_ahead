class AddUmpireIdColumnToUmpires < ActiveRecord::Migration
  def change
    add_column :umpires, :umpire_id, :integer
  end
end
