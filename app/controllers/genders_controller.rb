class GendersController < ApplicationController
  def create
    @gender = Gender.new(gender_params)
    if @gender.save
      redirect_to options_backoffices_path
    end
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
end
