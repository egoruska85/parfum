class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:update]

  def create
    @order = Order.find(params[:order_id])
    additional_variable = params[:order_item][:product_id]

    find_position = @order.order_items.find_by(product_id: additional_variable)

    if find_position != nil
      @order.product_in_order?(find_position.product_id)
      find_position.quantity += 1
      find_position.save
      @order.for_payment = @cart.total_discount
      redirect_to order_backoffice_path(@order), notice: 'Позиция успешно добавлена в заказ.'
    elsif find_position == nil
      @order_item = @order.order_items.build(order_item_params)

      if @order_item.save
       redirect_to order_backoffice_path(@order), notice: 'Позиция успешно добавлена в заказ.'
      else
       redirect_to order_backoffice_path(@order), alert: 'Ошибка при добавлении позиции.'
      end
    end
  end

  def update
    if @order_item.update(order_item_params)
      update_for_payment(@order_item)
      redirect_to order_path(order_backoffice_path), notice: 'Quantity was successfully updated.'
    else
      redirect_to order_path(order_backoffice_path), alert: 'Failed to update quantity.'
    end
  end


  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def update_for_payment(order_item)
    @order = Order.find_by(id: order_item.order_id)
    @order.for_payment = @order.total_discount
    @order.save
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
