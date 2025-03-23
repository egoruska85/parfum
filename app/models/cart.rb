class Cart < ApplicationRecord
  has_many :orderables
  has_many :products, through: :orderables


  def total_discount
    orderables.to_a.sum { |orderable| orderable.total_discount }
  end

  def see_prodduct_quantity
    orderables.to_a.sum { |orderable| orderable.quantity }
  end

  def orderables_count
    orderables.count
  end

  def total
    orderables.to_a.sum { |orderable| orderable.total }
  end
end
