class RelationshipsController < ApplicationController
  def new
  end

  def create
    partner = User.find_by(user_id: params[:user_id])
    if partner && BCrypt::Password.new(partner.invitation_digest).is_password?(params[:invitation_code])
      if partner.invitation_my_role == "monitor"
        relationship = Relationship.new(monitor_id: partner.id, monitored_id: current_user.id)
      elsif partner.invitation_my_role == "monitored"
        relationship = Relationship.new(monitor_id: current_user.id, monitored_id: partner.id)
      end
      if relationship.save
        redirect_to root_path
      else
        flash.now[:alert] = '連携できませんでした'
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = '連携コードが正しくありません'
      render :new, status: :unprocessable_entity
    end
  end

  def invitation_code
    @invitation_token = User.new_token
    current_user.attributes = {
      user_id: params[:user][:user_id],
      invitation_digest: User.digest(@invitation_token),
      invitation_made_at: Time.zone.now,
      invitation_my_role: params[:user][:invitation_my_role]
    }
    if current_user.save && params[:user][:invitation_my_role].present?
      render :invitation_code
    else
      flash.now[:alert] = '連携コードを発行出来ませんでした'
      render :new, status: :unprocessable_entity
    end
  end
end
