class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items

  def product_in_order?(product_id)
    products.exists?(product_id)
  end

  def total_discount
    order_items.to_a.sum { |orderable| orderable.total_discount }
  end

  def see_prodduct_quantity
    order_items.to_a.sum { |orderable| orderable.quantity }
  end

  def order_count
    order_items.count
  end

  def total
    order_items.to_a.sum { |order_item| order_item.total }
  end
end
