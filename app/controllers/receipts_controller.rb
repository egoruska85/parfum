class ReceiptsController < ApplicationController

  def activate
    @receipt = Receipt.find(params[:id])

    @receipt.receipt_items.each do |item|
      @product = Warehouse.find_by(product_id: item.product_id)
      if @product == nil
        new_position = Warehouse.new
        new_position.product_id = item.product_id
        new_position.quantity = item.quantity
        new_position.save
      elsif @product != nil
        @product.quantity += item.quantity
        @product.save
      end
    end
    @receipt.activation = true
    @receipt.save 
  end

  def deactivate
  end

end
