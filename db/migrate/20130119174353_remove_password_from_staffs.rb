class RemovePasswordFromStaffs < ActiveRecord::Migration
  def up
  	remove_column :staffs, :password
  end

  def down
  	add_column :staffs, :password, :string
  end
end
