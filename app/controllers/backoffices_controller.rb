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

  end
end
