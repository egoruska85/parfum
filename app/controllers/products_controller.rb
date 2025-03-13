class ProductsController < ApplicationController
  helper_method :recent_products
  
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end
  def show
    @product = Product.find(params[:id])
    set_page_options
  end

  helper_method :recent_products
  attr_accessor :product

  def recent_products
    [] if recently.none?
    Product.where(id: recently)
  end

  def recently
    session[:viewed_products] ||= []
  end

  def register_visit
    session[:viewed_products] ||= []
    session[:viewed_products] = ([product.id] + session[:viewed_products])
                                  .uniq
                                  .take(3)
  end

  def set_page_options
    @page_title = @product.name
  end

end
