class Product < ApplicationRecord
  belongs_to :gender
  belongs_to :category
  belongs_to :productdiscount
  belongs_to :country
  belongs_to :brand
  has_one_attached :image
  has_many_attached :images

  has_many :orderables
  has_many :carts, through: :orderables

  has_many :order_items
  has_many :orders, through: :order_items
end
