class RemoveContactsTable < ActiveRecord::Migration
  def up
    drop_table :contacts
  end

  def down
    create_table :contacts do |t|
	t.string   "first_name"
	t.string   "last_name"
	t.string   "address"
	t.string   "email"
	t.string   "telephone"
	t.string   "team_name"
	t.time     "qualifications"
	t.datetime "created_at",     :null => false
	t.datetime "updated_at",     :null => false
    end
  end
end
