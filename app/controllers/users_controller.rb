class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[index new create]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(:users, notice: 'User was successfully created')
    else
      flash.now[:alert] = 'User signin failed'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to(:users, notice: 'User was successfully updated')
    else
      flash.now[:alert] = 'User update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to(:users, notice: 'User was successfully destroyed', status: :see_other)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_id, :name, :email, :password, :password_confirmation)
  end
end
