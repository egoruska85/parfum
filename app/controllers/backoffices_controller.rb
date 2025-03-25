class BackofficesController < ApplicationController
  before_action :authenticate_user!, :navbar_links, :admin

  def index
    @orders = Order.order(created_at: :desc)

    check_mobile_device
  end

  def options
    @genders = Gender.all
    @categories = Category.all
    @currencies = Currency.all
  end

  def order
    @order = Order.find(params[:id])
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
