class MainController < ApplicationController
  before_action :set_page_options
  def index
    @genders = Gender.all
    @categories = Category.all
  end

  def set_page_options
    @page_title = "Parfum-tm"
    @page_description = "Parfum"
    @page_keywords = "Man Woman Kids"
  end
end
