class AddMatchIdToUmpires < ActiveRecord::Migration
  def change
  add_column :umpires, :match_id, :integer
  end
end
