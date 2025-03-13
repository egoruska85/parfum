class BackofficesController < ApplicationController
  def options
    @genders = Gender.all
    @categories = Category.all
    @currencies = Currency.all
  end

  def interface
    @carouseles = Carousel.all
  end

  def products
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end
end
