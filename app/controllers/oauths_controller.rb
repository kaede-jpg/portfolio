class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if logged_in?
      link_line_account(provider)
    else
      login_with_line(provider)
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end

  def link_line_account(provider)
    if add_provider_to_user(provider)
      redirect_to root_path, notice: provider.titleize + t('notice.link_line_successful')
    else
      redirect_to root_path, alert: provider.titleize + t('alert.link_line_failed')
    end
  end

  def login_with_line(provider)
    if (@user = login_from(provider))
      redirect_to records_path, notice: provider.titleize + t('notice.external_login_successful')
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to records_path, notice: provider.titleize + t('notice.external_login_successful')
      rescue StandardError
        redirect_to login_path, alert: provider.titleize + t('alert.external_login_failed')
      end
    end
  end
end
