class CategoriesController < ApplicationController

  def show
    @genders = Gender.all
    @category = Category.find(params[:id])
    gender = @category.gender_id
    @categories = Category.where(gender_id: gender)
    @products = Product.where(category_id: @category.id)

    @gender = Gender.find_by(id: gender)
    set_page_options
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to options_backoffices_path
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to options_backoffices_path, notice: "Удалено"
  end

  private

  def category_params
    params.require(:category).permit(:name, :name_tm, :gender_id)
  end

  private

  def set_page_options
    @page_title = "#{@category.name} " + "#{@gender.name}"
  end
end
