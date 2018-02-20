class Location < ApplicationRecord
  validates :address,
           :post_code,
           presence: true,
           uniqueness: true
end
