class ReceiptItem < ApplicationRecord
  belongs_to :receipt
  belongs_to :product

  def total
    price.to_f * quantity
  end
end
