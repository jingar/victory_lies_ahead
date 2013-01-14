class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :when

      t.timestamps
    end
  end
end
