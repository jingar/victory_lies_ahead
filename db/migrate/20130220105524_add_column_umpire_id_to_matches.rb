class AddColumnUmpireIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :umpire_id, :integer
  end
end
