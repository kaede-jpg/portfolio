class RelationshipsController < ApplicationController
  before_action :initialize_relationship
  def menu; end

  def create
    partner = User.find_by(user_id: relationship_params[:user_id])
    if valid_partner?(partner, relationship_params[:relationship_code])
      create_relationship(partner)
      if @relationship.save
        current_user.save
        redirect_to records_path, notice: t('notice.create_relationship')
      else
        flash.now[:alert] = t('alert.create_relationship_failed')
        render :menu, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = t('alert.not_correct_code')
      render :menu, status: :unprocessable_entity
    end
  end

  def relationship_code
    if relationship_code_params[:role].present?
      create_relationship_attributes(relationship_code_params[:user_id], relationship_code_params[:role])
      if current_user.save
        render :relationship_code
      else
        flash.now[:alert] = t('alert.create_code_failed')
        render :menu, status: :unprocessable_entity
      end
    else
      current_user.errors.add(:role, t('alert.select'))
      flash.now[:alert] = t('alert.create_code_failed')
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy!
    redirect_to records_path, notice: t('notice.delete_relationship')
  end

  private

  def relationship_code_params
    params.require(:user).permit(:user_id, :role)
  end

  def relationship_params
    params.require(:relationship).permit(:user_id, :relationship_code)
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

  def valid_partner?(partner, relationship_code)
    partner&.relationship_digest && BCrypt::Password.new(partner.relationship_digest).is_password?(relationship_code)
  end

  def create_relationship_attributes(user_id, role)
    @relationship_token = User.new_token
    current_user.attributes = {
      user_id:,
      relationship_digest: User.digest(@relationship_token),
      relationship_code_made_at: Time.zone.now,
      role:
    }
  end

  def create_relationship(partner)
    if partner.role == 'monitor'
      @relationship = Relationship.new(monitor_id: partner.id, monitored_id: current_user.id)
      current_user.role = 'monitored'
    elsif partner.role == 'monitored'
      @relationship = Relationship.new(monitor_id: current_user.id, monitored_id: partner.id)
      current_user.role = 'monitor'
    end
  end
end
