class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:update]

  def update
    if @order_item.update(order_item_params)
      redirect_to order_path(order_backoffice_path), notice: 'Quantity was successfully updated.'
    else
      redirect_to order_path(order_backoffice_path), alert: 'Failed to update quantity.'
    end
  end

  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end
end
