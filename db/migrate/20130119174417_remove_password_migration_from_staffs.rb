class RemovePasswordMigrationFromStaffs < ActiveRecord::Migration
  def up
  	remove_column :staffs, :password_confirmation
  end

  def down
  	add_column :staffs, :password_confirmation, :string
  end
end
