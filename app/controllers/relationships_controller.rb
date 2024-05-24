class RelationshipsController < ApplicationController
  before_action :initialize_relationship
  def new; end

  def create
    partner = User.find_by(user_id: params[:relationship][:user_id])
    if valid_partner?(partner, params[:relationship][:invitation_code])
      create_relationship(partner)
      if @relationship.save
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
    if params[:user][:invitation_my_role].present?
      create_invitation_attributes(params[:user][:user_id], params[:user][:invitation_my_role])
      if current_user.save
        render :invitation_code
      else
        flash.now[:alert] = '連携コードを発行出来ませんでした'
        render :new, status: :unprocessable_entity
      end
    else
      current_user.errors.add(:role, 'を選択してください')
      flash.now[:alert] = '連携コードを発行出来ませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def initialize_relationship
    @relationship = Relationship.new
  end

  def valid_partner?(partner, invitation_code)
    partner&.invitation_digest && BCrypt::Password.new(partner.invitation_digest).is_password?(invitation_code)
  end

  def create_relationship(partner)
    if partner.invitation_my_role == 'monitor'
      @relationship = Relationship.new(monitor_id: partner.id, monitored_id: current_user.id)
    elsif partner.invitation_my_role == 'monitored'
      @relationship = Relationship.new(monitor_id: current_user.id, monitored_id: partner.id)
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
