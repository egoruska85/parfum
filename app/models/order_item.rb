class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def total
    product.price.to_f * quantity
  end
end
