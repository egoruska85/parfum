class Product < ApplicationRecord
  belongs_to :gender
  belongs_to :category
  belongs_to :productdiscount
  belongs_to :country
  belongs_to :brand
  has_one_attached :image
  has_many_attached :images
end
