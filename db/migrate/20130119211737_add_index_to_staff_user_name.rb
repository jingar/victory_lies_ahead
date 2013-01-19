class AddIndexToStaffUserName < ActiveRecord::Migration
  def change
  	add_index :staffs, :user_name, unique: true
  end
end
