class ChangedUsedInTicketsToString < ActiveRecord::Migration
  def up
    change_column :tickets, :used, :string
  end

  def down
    change_column :tickets, :used, :boolean
  end
end
