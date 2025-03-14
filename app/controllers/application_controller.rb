class ApplicationController < ActionController::Base
  before_action :set_locale, :set_render_cart, :initialize_cart, :search_field

  private

  def navbar_links
    @genders = Gender.all
    @categories = Category.all
  end

  def search_field
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end


  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    @cart ||= Cart.find_by(id: session[:cart_id])

    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end
  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  def default_url_options
    { locale: I18n.locale }
  end
end
