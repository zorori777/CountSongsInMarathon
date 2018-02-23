class Song < ApplicationRecord
  belongs_to :song, optional: true
end
