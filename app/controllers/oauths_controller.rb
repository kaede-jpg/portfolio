class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if (@user = login_from(provider))
      redirect_to records_path, notice: provider.titleize + t('notice.exturnal_login_successful')
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to records_path, notice: provider.titleize + t('notice.exturnal_login_successful')
      rescue StandardError
        redirect_to login_path, alert: provider.titleize + t('alert.eexternal_login_failed')
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end
end
