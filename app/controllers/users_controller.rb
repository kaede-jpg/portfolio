class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[index new create activate]
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
      render :send_activation, status: :unprocessable_entity
    else
      flash.now[:alert] = t('activerecord.models.user') + t('alert.create_failed')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      if @user.previous_changes[:email]
        render :send_activation, status: :unprocessable_entity
      else
        redirect_to(:users, notice: t('activerecord.models.user') + t('notice.update'))
      end
    else
      flash.now[:alert] = t('activerecord.models.user') + t('alert.update_failed')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to(:users, notice: t('activerecord.models.user') + t('notice.destroy'), status: :see_other)
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to(login_path, :notice => t('notice.activation_success'))
    else
      not_authenticated
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_id, :name, :email, :password, :password_confirmation)
  end
end
