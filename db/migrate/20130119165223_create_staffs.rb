class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string, :first_name
      t.string, :last_name
      t.string, :password
      t.string, :password_confirmation
      t.string :type

      t.timestamps
    end
  end
end
