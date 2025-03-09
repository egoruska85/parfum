class BackofficesController < ApplicationController
  def options
    @genders = Gender.all
    @categories = Category.all
  end

  def products
    
  end
end
