class Receipt < ApplicationRecord
  has_many :receipt_items
  has_many :products, through: :receipt_items

  def product_in_receipt?(product_id)
    products.exists?(product_id)
  end

  def total
    receipt_items.to_a.sum { |receipt_item| receipt_item.total }
  end
end
