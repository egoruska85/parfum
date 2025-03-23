class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def product_discount
    result = product.price.to_f - (product.price.to_f * Productdiscount.last.value.to_i) / 100.0
    result.round.to_f
  end

  def total_discount
    result = product_discount * quantity
  end

  def total
    product.price.to_f * quantity
  end
end
