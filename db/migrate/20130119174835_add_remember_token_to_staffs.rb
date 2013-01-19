class AddRememberTokenToStaffs < ActiveRecord::Migration
  def change
 	add_column :staffs, :remember_token, :string
	add_index :staffs, :remember_token
  end
end
