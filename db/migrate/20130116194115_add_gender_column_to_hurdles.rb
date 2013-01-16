class AddGenderColumnToHurdles < ActiveRecord::Migration
    def change
	add_column :hurdles, :gender, :integer
    end
end
