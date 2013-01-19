class AddUserNameColumnToStaff < ActiveRecord::Migration
  def change
  	add_column :staffs, :user_name, :string
  end
end
