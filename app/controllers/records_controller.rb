class RecordsController < ApplicationController
  def index
    @record = current_user.records.build
    @comment = current_user.comments.build
    @stamps = Stamp.order(:id)
    partner = set_partner
    @records = records(partner)
    @message = message(partner)
  end

  def create
    @record = current_user.records.build(meal_image: resized_image(record_params[:meal_image]))
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

  def resized_image(image_params)
    return if image_params.blank?

    image = MiniMagick::Image.read(image_params.tempfile)
                             .format('webp')
                             .combine_options do |c|
      c.resize '442x442^'
      c.gravity 'center'
      c.extent '442x442'
    end
    ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(image.to_blob),
      filename: "#{SecureRandom.hex}.webp",
      content_type: 'image/webp'
    )
  end

  def set_partner
    return current_user unless current_user.related?
    return User.monitored_by(current_user) if current_user.monitor?

    User.monitors_of(current_user)
  end

  def records(partner)
    return Record.where(user_id: partner.id).preload(comments: :user, stamped_records: :stamp) if current_user.related? && current_user.monitor?

    current_user.records.preload(comments: :user, stamped_records: :stamp)
  end

  def message(partner)
    return partner.name + t('message.monitor') if current_user.related? && current_user.monitor?
    return partner.map(&:name).join(t('message.and')) + t('message.monitored_from') if current_user.related?
    return t('message.not_related') unless current_user.guest
    return current_user.name + t('message.monitor') if current_user.monitor?

    current_user.name + t('message.monitored_from')
  end
end
