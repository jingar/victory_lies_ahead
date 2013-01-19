class ChangeColumnGenderInHurdlesToString < ActiveRecord::Migration
    def up
	change_column :hurdles, :gender, :string
    end

    def down
	change_column :hurdles, :gender, :int
    end
end
