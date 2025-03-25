class OrdersController < ApplicationController
  before_action :authenticate_user!, :navbar_links

  def show
    navbar_links
    @order = Order.find(params[:id])
  end

  def add
    @order = Order.new
    @order.user_id = current_user.id
    @order.for_payment = @cart.total_discount
    if @order.save
      move_items_from_cart_to_order(@cart, @order)
      redirect_to @order, notice: 'Заказ успешно создан.'
    else
      render :new
    end
  end

  def remove
    current_order_item = OrderItem.find_by(id: params[:id])
    current_order_item.destroy

    @order = Order.find_by(id: current_order_item.order_id)
    @order.for_payment = @order.total_discount
    @order.save

    redirect_to order_backoffice_path(current_order_item.order_id)
  end

  private

  def order_params
    params.require(:order).permit(:user_id)
  end

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end

  def move_items_from_cart_to_order(cart, order)
    cart.orderables.each.each do |orderable|
      order.order_items.create(product: orderable.product, quantity: orderable.quantity)
    end
    @cart.orderables.destroy_all # очищаем корзину после перемещения
  end

end
