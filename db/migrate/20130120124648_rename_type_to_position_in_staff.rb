class RenameTypeToPositionInStaff < ActiveRecord::Migration
  def up
  	rename_column :staffs, :type, :position
  end

  def down
  end
end
