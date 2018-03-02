class Song < ApplicationRecord
  belongs_to :song, optional: true

  scope :todays_songs, -> { where("created_at >= ?", Time.zone.now.beginning_of_day)}
end
