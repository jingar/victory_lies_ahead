class AddPassowrdDigestToStaff < ActiveRecord::Migration
  def change
    add_column :staffs, :password_digest, :string
  end
end
