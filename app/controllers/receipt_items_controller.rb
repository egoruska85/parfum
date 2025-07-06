class ReceiptItemsController < ApplicationController
  before_action :set_receipt_item

  def create
    @receipt = Receipt.find(params[:receipt_id])
    additional_variable = params[:receipt_item][:product_id]

    find_position = @receipt.receipt_items.find_by(product_id: additional_variable)

    if find_position != nil
      @receipt.product_in_receipt?(find_position.product_id)
      find_position.quantity += 1
      find_position.save

      redirect_to order_backoffice_path(@receipt), notice: 'Позиция успешно добавлена в приход.'
    elsif find_position == nil
      @receipt_item = @receipt.receipt_items.build(receipt_item_params)

      if @receipt_item.save
       redirect_to receipt_backoffice_path(@receipt), notice: 'Позиция успешно добавлена в приход.'
      else
       redirect_to receipt_backoffice_path(@receipt), alert: 'Ошибка при добавлении позиции.'
      end
    end
  end



  def update_quantity
    
    @receipt_item.update(receipt_item_params)
    #quantity = @receipt_item.quantity
    #update_quantity_product(@receipt_item.product.id, @quantity)
  end

  private

  def set_receipt_item
    @receipt_item = ReceiptItem.find(params[:id])
  end

  def update_quantity_product(product_id, quantity)
    @product = Product.find_by(id: product_id)
    @product.quantity += quantity
    @product.save
  end

  def receipt_item_params
    params.require(:receipt_item).permit(:quantity, :price, :product_id)
  end

  def receipt_item_params
    params.require(:receipt_item).permit(:quantity, :product_id)
  end
end
