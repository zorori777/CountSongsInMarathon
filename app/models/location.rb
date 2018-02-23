class Location < ApplicationRecord
  validates :address,
           presence: true,
           uniqueness: true

  has_many :songs
end
