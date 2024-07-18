class RelationshipsController < ApplicationController
  before_action :initialize_relationship
  def menu; end

  def create
    partner = User.find_by(relationship_code: relationship_params[:relationship_code])
    partner_valid = partner&.relationship_code == relationship_params[:relationship_code]
    if partner_valid && create_relationship(partner)
      current_user.save
      redirect_to records_path, notice: t('notice.create_relationship')
    else
      flash.now[:alert] = flash.now[:alert] = partner_valid ? t('alert.create_relationship_failed') : t('alert.not_correct_code')
      render :menu, status: :unprocessable_entity
    end
  end

  def relationship_code
    if relationship_code_params[:role].present?
      if create_relationship_attributes(relationship_code_params[:role])
        render :relationship_code
      else
        flash.now[:alert] = t('alert.create_code_failed')
        render :menu, status: :unprocessable_entity
      end
    else
      current_user.errors.add(:role, t('alert.select'))
      flash.now[:alert] = t('alert.create_code_failed')
      render :menu, status: :unprocessable_entity
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy!
    redirect_to records_path, notice: t('notice.delete_relationship')
  end

  private

  def relationship_code_params
    params.require(:user).permit(:role)
  end

  def relationship_params
    params.require(:relationship).permit(:relationship_code)
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

  def create_relationship_attributes(role)
    @relationship_token = SecureRandom.urlsafe_base64
    current_user.attributes = {
      relationship_code: @relationship_token,
      relationship_code_made_at: Time.zone.now,
      role:
    }
    current_user.save
  end

  def create_relationship(partner)
    if partner.monitor?
      @relationship = Relationship.new(monitor_id: partner.id, monitored_id: current_user.id)
      current_user.monitored!
    elsif partner.monitored?
      @relationship = Relationship.new(monitor_id: current_user.id, monitored_id: partner.id)
      current_user.monitor!
    end
    @relationship.save
  end
end
