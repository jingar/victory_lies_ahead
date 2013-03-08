class AddDefaultValueToTickets < ActiveRecord::Migration
    def up
      change_column :tickets, :used, :boolean, :default => false
    end

    def down
      change_column :tickets, :used, :default => nil
    end
end
