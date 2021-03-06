class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :order_id
      t.integer :adult_tickets_bought
      t.integer :concession_tickets_bought
      t.boolean :used

      t.timestamps
    end
  end
end
