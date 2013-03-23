class CreateAdminScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :amount
      t.integer :matches_id
      t.integer :wattball_id

      t.timestamps
    end
  end
end
