class ChangedDefaultValueInTicketsTo0 < ActiveRecord::Migration
  def up
    change_column :tickets, :adult_tickets_bought, :integer, :default => 0
    change_column :tickets, :concession_tickets_bought, :integer, :default => 0
  end

  def down
  end
end
