class RelationshipsController < ApplicationController
  before_action :initialize_relationship
  def menu; end

  def create
    partner = User.find_by(user_id: relationship_params[:user_id])
    if valid_partner?(partner, relationship_params[:invitation_code])
      create_relationship(partner)
      if @relationship.save
        current_user.save
        redirect_to records_path, notice: '連携しました'
      else
        flash.now[:alert] = '連携できませんでした'
        render :menu, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = '連携コードが正しくありません'
      render :menu, status: :unprocessable_entity
    end
  end

  def invitation_code
    if invitation_params[:invitation_my_role].present?
      create_invitation_attributes(invitation_params[:user_id], invitation_params[:invitation_my_role])
      if current_user.save
        render :invitation_code
      else
        flash.now[:alert] = '連携コードを発行出来ませんでした'
        render :menu, status: :unprocessable_entity
      end
    else
      current_user.errors.add(:role, 'を選択してください')
      flash.now[:alert] = '連携コードを発行出来ませんでした'
      render :menu, status: :unprocessable_entity
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy!
    redirect_to records_path, notice: '連携を解除しました'
  end

  private

  def invitation_params
    params.require(:user).permit(:user_id, :invitation_my_role)
  end

  def relationship_params
    params.require(:relationship).permit(:user_id, :invitation_code)
  end

  def initialize_relationship
    @relationship = Relationship.new
    return unless current_user.related?
    if current_user.monitor?
      @monitored_user = User.monitored_by(current_user)
    else
      @monitor_users = User.monitors_of(current_user)
    end
  end

  def valid_partner?(partner, invitation_code)
    partner&.invitation_digest && BCrypt::Password.new(partner.invitation_digest).is_password?(invitation_code)
  end

  def create_relationship(partner)
    if partner.invitation_my_role == 'monitor'
      @relationship = Relationship.new(monitor_id: partner.id, monitored_id: current_user.id)
      current_user.invitation_my_role = 'monitored'
    elsif partner.invitation_my_role == 'monitored'
      @relationship = Relationship.new(monitor_id: current_user.id, monitored_id: partner.id)
      current_user.invitation_my_role = 'monitor'
    end
  end

  def create_invitation_attributes(user_id, invitation_my_role)
    @invitation_token = User.new_token
    current_user.attributes = {
      user_id:,
      invitation_digest: User.digest(@invitation_token),
      invitation_made_at: Time.zone.now,
      invitation_my_role:
    }
  end
end
