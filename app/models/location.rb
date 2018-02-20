class Location < ApplicationRecord
  validates :address,
           presence: true,
           uniqueness: true
end
