class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :post_code, null: false
      t.string :address,   null: false

      t.timestamps
    end
  end
end
