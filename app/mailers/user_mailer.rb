class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  default from: 'information@punikatsu-monitor.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    mail(to: user.email,
         subject: "【#{t('helpers.title')}】#{t('mailer.password_reset')}")
  end

  def activation_needed_email(user)
    @user = user
    @url  = activate_user_url(@user.activation_token)
    mail(to: user.email,
         subject: "【#{t('helpers.title')}】#{t('mailer.activation_needed')}")
  end

  def activation_success_email(user)
    @user = user
    @url  = login_url
    mail(to: user.email,
         subject: "【#{t('helpers.title')}】#{t('mailer.activation_success')}")
  end
end
