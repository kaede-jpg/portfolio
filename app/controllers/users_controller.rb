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
      redirect_to(:users, notice: t('activerecord.models.user') + t('notice.create'))
    else
      flash.now[:alert] = t('activerecord.models.user') + t('alert.create_failed')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to(:users, notice: t('activerecord.models.user') + t('notice.update'))
    else
      flash.now[:alert] = t('activerecord.models.user') + t('notice.update_failed')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to(:users, notice: t('activerecord.models.user') + t('notice.destroy'), status: :see_other)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_id, :name, :email, :password, :password_confirmation)
  end
end
