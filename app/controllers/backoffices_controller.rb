class BackofficesController < ApplicationController
  before_action :authenticate_user!, :navbar_links, :admin, :check_mobile_device, except: [:delivery_operator, :delivery_more_detail]

  def index
    @orders = Order.order(created_at: :desc)
  end

  def delivery_operator
    one_stage = Order.where(sent: true)
    two_stage = one_stage.where(closed: nil)
    @orders = two_stage
  end

  def delivery_more_detail
    @order = Order.find(params[:id])
    if @order.sent != true
      redirect_to delivery_operator_backoffices_path
    end
  end

  def options
    @genders = Gender.all
    @categories = Category.all
    @currencies = Currency.all
  end

  def order
    @order = Order.find(params[:id])
    @delivery_man = User.where(delivery_man: true)
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def interface
    @carouseles = Carousel.all
  end

  def products
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  private

  def admin
    if current_user.admin != true and user_signed_in?
      redirect_to root_path
    end
  end

  def check_mobile_device
    if request.user_agent =~ /Mobi|Android/i
      redirect_to root_path
    end
  end

end
