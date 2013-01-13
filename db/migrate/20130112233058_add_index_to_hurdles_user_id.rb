class AddIndexToHurdlesUserId < ActiveRecord::Migration
  def change
  	add_index :hurdles, [:user_id, :created_at]
  end
end
