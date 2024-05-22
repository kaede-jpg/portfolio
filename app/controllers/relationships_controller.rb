class RelationshipsController < ApplicationController
  def new; end

  def create; end

  def invitation_code
    @invitation_token = User.new_token
    current_user.attributes = {
      invitation_digest: User.digest(@invitation_token),
      invitation_made_at: Time.zone.now,
      invitation_my_role: params[:invitation_my_role]
    }
    if current_user.save && params[:invitation_my_role].present?
      render :invitation_code
    else
      flash.now[:alert] = '招待コードを発行出来ませんでした'
      render :new, status: :unprocessable_entity
    end
  end
end
