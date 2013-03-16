class ChangedDefaultValueInTicketsToString < ActiveRecord::Migration
  def up
    change_column :tickets, :used, :string, :default => "Not Expired"
  end

  def down
  end
end
