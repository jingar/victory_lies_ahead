class AddColumnRoundToHurdlesTable < ActiveRecord::Migration
  def up
    add_column :hurdles, :round, :integer
  end

  def down
    remove_column :hurdles, :round
  end
end
