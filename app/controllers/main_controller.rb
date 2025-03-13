class MainController < ApplicationController
  before_action :set_page_options
  def index
    @genders = Gender.all
    @categories = Category.all


    @a = -1
    @carousels = Carousel.where(id: 2..100)
    @carousel_active = Carousel.first
  end

  def set_page_options
    @page_title = "Parfum-tm"
    @page_description = "Parfum"
    @page_keywords = "Man Woman Kids"
  end
end
