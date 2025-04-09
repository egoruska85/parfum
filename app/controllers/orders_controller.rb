class OrdersController < ApplicationController
  before_action :navbar_links

  def access
    @order = Order.find(params[:id])
  end

  def verify
    session[:pin_code] = params[:order][:pin_code].to_i
    #@order = Order.find_by(pin: pin)
    @order = Order.find(params[:id])

    if @order.pin.to_i == session[:pin_code]
      redirect_to order_path(@order)
    else
      session[:pin_code] = nil
      redirect_to root_path
      flash[:notice] = session[:pin_code]
    end
  end

  def show
    navbar_links
    @order = Order.find(params[:id])

    unless user_signed_in?
      if session[:pin_code].nil? and session[:pin] != @order.pin
        redirect_to access_order_path
        return
      end
    end

    if @order.ordered == true
      redirect_to order_order_path(@order)
    end
    @page_title = t('order.number') + "#{@order.id}"
  end

  def order
    @order = Order.find(params[:id])

    unless user_signed_in?
      if session[:pin_code].nil? and session[:pin] != @order.pin
        redirect_to access_order_path
        return
      end
    end

    session[:pin_code] = nil

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
    end
    @order.for_payment = @cart.total_discount
    @order.payment = 0
    @order.change = 0
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
    phone = params[:order][:phone]
    pin = params[:order][:pin]

    unless current_user
      unless valid_pin_code?(pin)
        @order.errors.add(:phone_number)
        return
      end
    end

    if valid_phone_number?(phone)
      @order.update(order_params)
      redirect_to order_path(@order)
    else
      @order.errors.add(:phone_number, "is not a valid phone number")
      render :show
    end
  end

  def admin_ordered
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to order_backoffice_path(@order)
    end
  end

  def update_status_delivery
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to delivery_more_detail_backoffice_path(@order)
    end
  end

  def update_pay_delivery
    @order = Order.find(params[:id])
    pay = params[:order][:pay].to_f

    @order.payment += pay

    @order.change = @order.payment - @order.for_payment if @order.payment > @order.for_payment

    change(@order)

    if @order.update(order_params)
      flash[:notice] = "Внесено: " + pay.to_f.to_s
      redirect_to delivery_more_detail_backoffice_path(@order)
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
                                  :username, :change, :ordered, :refusal, :closed, :pin)
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

  def valid_phone_number?(phone_number)
    # Пример регулярного выражения для проверки формата номера телефона
    # Это регулярное выражение проверяет, что номер состоит из 10 цифр
    phone_number.match?(/\A\+\d{11}\z/)
  end

  def valid_pin_code?(pin)
    # Пример регулярного выражения для проверки формата номера телефона
    # Это регулярное выражение проверяет, что номер состоит из 10 цифр
    pin.match?(/\A\d{4}\z/)
  end

end
