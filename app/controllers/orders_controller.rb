class OrdersController < ApplicationController
  before_action :navbar_links

  def show
    navbar_links
    @order = Order.find(params[:id])

    if @order.ordered == true
      redirect_to order_order_path(@order)
    end
    @page_title = t('order.number') + "#{@order.id}"
  end

  def order
    @order = Order.find(params[:id])
    if @order.ordered != true
      redirect_to order_path(@order)
    end
    @page_title = t('order.number') + "#{@order.id}"
  end

  def add
    @order = Order.new
    if current_user
      @order.user_id = current_user.id
      @order.username = current_user.username
    else
      @order.username = 'Гость'
    end
    @order.for_payment = @cart.total_discount
    @order.payment = 0
    if @order.save
      move_items_from_cart_to_order(@cart, @order)
      redirect_to @order, notice: 'Заказ успешно создан.'
    else
      render :new
    end
  end

  def update
    @order = Order.find(params[:id])
    pay = params[:order][:pay].to_f

    @order.payment += pay

    @order.change = @order.payment - @order.for_payment if @order.payment > @order.for_payment

    change(@order)

    if @order.update(order_params)
      flash[:notice] = "Внесено: " + pay.to_f.to_s
      redirect_to order_backoffice_path(@order)
    end

  end

  def user_ordered
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to order_path(@order)
    end
  end

  def admin_ordered
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to order_backoffice_path(@order)
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

  def change(order)
    if order.for_payment < order.payment
      order.payment = order.for_payment
    end
  end

  def order_params
    params.require(:order).permit(:user_id, :phone, :post_code, :city, :district,
                                  :street, :house, :flat,:for_payment, :payment,
                                  :canceled, :accepted, :sent, :delivered, :received,
                                  :user, :change, :ordered, :refusal, :closed)
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
