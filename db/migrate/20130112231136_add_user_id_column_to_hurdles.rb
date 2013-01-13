class AddUserIdColumnToHurdles < ActiveRecord::Migration
  def change
  	add_column :hurdles, :user_id, :integer
  end
end
