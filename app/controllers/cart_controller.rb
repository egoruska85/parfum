class CartController < ApplicationController
  def show
    @render_cart = true
    @genders = Gender.all
    @currency = Currency.last
  end
  def ordercart

  end

  def add
    @currency = Currency.last
    @genders = Gender.all
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(product_id: @product.id)
    if current_orderable && quantity > 0
      current_orderable.update(quantity:)
    elsif quantity <= 0
      current_orderable.destroy
    else
      @cart.orderables.create(product: @product, quantity:)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [ turbo_stream.replace('cart',
                                                    partial: 'cart/cart',
                                                    locals: { cart: @cart })]
      end
    end
  end

  def remove
    @genders = Gender.all
    Orderable.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [ turbo_stream.replace('cart',
                                                    partial: 'cart/cart',
                                                    locals: { cart: @cart })]
      end
    end
  end
end
