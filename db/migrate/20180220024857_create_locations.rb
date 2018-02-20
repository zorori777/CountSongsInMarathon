class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :address,   null: false
      t.string :post_code, null: false

      t.timestamps
    end
    add_index :locations, :address, unique: true
  end
end
