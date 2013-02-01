class CreateHeats < ActiveRecord::Migration
  def change
    create_table :heats do |t|
      t.datetime :when
      t.string :gender

      t.timestamps
    end
  end
end
