class CurrenciesController < ApplicationController
  def create
    @currency = Currency.new(currency_params)
    @currency.save
    redirect_to options_backoffices_path
  end

  def destroy
    @currency = Currency.find(params[:id])
    @currency.destroy
    redirect_to options_backoffices_path, notice: "Удалено"
  end

  private

  def currency_params
    params.require(:currency).permit(:name, :name_tm, :banknote)
  end
end
