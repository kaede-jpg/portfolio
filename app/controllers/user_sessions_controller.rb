class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to records_path, notice: t('notice.login_successful')
    else
      flash.now[:alert] = t('alert.login_failed')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('notice.logged_out'), status: :see_other
  end
end
