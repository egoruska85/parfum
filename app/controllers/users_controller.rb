class UsersController < ApplicationController
  before_action :authenticate_user!, :navbar_links
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin!, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_backoffice_path(@user)
    end
  end

  def destroy
  end

  def orders
    @orders = Order.where(user_id: current_user.id).order(created_at: :desc)
  end

  def order

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin, :operator, :personal, :delivery_man)
  end

  def authorize_admin!
    redirect_to root_path, alert: 'У вас нет прав для доступа к этой странице.' unless current_user&.admin?
  end

end
