class ApplicationController < ActionController::Base
  before_action :set_locale, :set_render_cart, :initialize_cart, :search_field
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def see_count_cart
    @positions = @cart.orderables.count
  end

  def navbar_links
    @genders = Gender.all
    @categories = Category.all
    @currency = Currency.last
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

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
