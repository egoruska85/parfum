class CarouselsController < ApplicationController
  def create
    @carousel = Carousel.new(carousel_params)
    @carousel.save
    redirect_to interface_backoffices_path
  end

  def destroy
    @carousel = Carousel.find(params[:id])
    @carousel.destroy
    redirect_to interface_backoffices_path, notice: "Удалено"
  end

  private

  def carousel_params
    params.require(:carousel).permit(:title_ru, :title_tm, :desc_ru, :desc_tm, :image)
  end
end
