class RecordsController < ApplicationController
  def index
    @record = current_user.records.build
    @comment = current_user.comments.build
    @stamps = Stamp.order(:id)
    partner = set_partner
    @records = set_records(partner)
    @message = set_message(partner)
  end

  def create
    @record = current_user.records.build(record_params)
    @record.save!
    MealAdviseJob.perform_later(@record)
    LinebotJob.perform_later(@record)
    redirect_to records_path, notice: t('activerecord.models.record') + t('notice.create')
  end

  def destroy
    @record = current_user.records.find(params[:id])
    @record.destroy!
    redirect_to records_path, notice: t('activerecord.models.record') + t('notice.destroy')
  end

  private

  def record_params
    params.require(:record).permit(:meal_image)
  end

  def set_partner
    return current_user unless current_user.related?
    return User.monitored_by(current_user) if current_user.monitor?
    User.monitors_of(current_user)
  end

  def set_records(partner)
    return Record.where(user_id: partner.id).preload(comments: :user, stamped_records: :stamp) if current_user.related? && current_user.monitor?
    current_user.records.preload(comments: :user, stamped_records: :stamp)
  end

  def set_message(partner)
    return partner.name + t('message.monitor') if current_user.related? && current_user.monitor?
    return partner.map(&:name).join(t('message.and')) + t('message.monitored_from') if current_user.related?
    return t('message.not_related') unless current_user.guest
    return current_user.name + t('message.monitor') if current_user.monitor?
    current_user.name + t('message.monitored_from')
  end

end
