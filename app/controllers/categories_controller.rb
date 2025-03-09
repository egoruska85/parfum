class CategoriesController < ApplicationController
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
end
