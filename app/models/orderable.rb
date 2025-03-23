class Orderable < ApplicationRecord
  belongs_to :product
  belongs_to :cart

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
