class GendersController < ApplicationController
  def create
    @gender = Gender.new(gender_params)
    if @gender.save
      redirect_to options_backoffices_path
    end
  end

  def show
    @gender = Gender.find(params[:id])
    @genders = Gender.all

    @categories = Category.where(gender_id: @gender.id )
    @products = Product.where(gender_id: @gender.id )
    set_page_options
  end

  def destroy
    @gender = Gender.find(params[:id])
    @gender.destroy
    redirect_to options_backoffices_path, notice: "Удалено"
  end

  private

  def gender_params
    params.require(:gender).permit(:name, :name_tm)
  end

  private

  def set_page_options
    @page_title = @gender.name
  end
end
