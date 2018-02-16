class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string  :title, null: false
      t.string  :image
      t.string  :artist_name
      t.string  :external_url

      t.timestamps
    end
  end
end
