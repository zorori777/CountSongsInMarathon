class AddLocationRefToSongs < ActiveRecord::Migration[5.1]
  def change
    add_reference :songs, :location, foreign_key: true
  end
end
