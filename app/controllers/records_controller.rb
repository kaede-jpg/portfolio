class RecordsController < ApplicationController
  def index
    @stamps = Stamp.all
    @comment = current_user.comments.build
    if current_user.related?
      if current_user.monitor?
        monitored = User.monitored_by(current_user)
        @records = Record.where(user_id: monitored.id).includes(comments: :user, stamped_records: :stamp)
        @message = monitored.name + t('message.monitor')
      else
        monitors = User.monitors_of(current_user)
        @records = current_user.records.includes(comments: :user, stamped_records: :stamp)
        @message = monitors.map(&:name).join(t('message.and')) + t('message.monitored_from')
      end
    else
      @records = current_user.records.includes(comments: :user, stamped_records: :stamp)
      @message = t('message.not_related')
    end
  end

  def new
    @record = current_user.records.build
  end

  def create
    @record = current_user.records.build(record_params)
    if @record.save
      redirect_to records_path, notice: t('activerecord.models.record') + t('notice.create')
    else
      flash.now[:alert] = t('activerecord.models.record') + t('alert.create_failed')
      render :new, status: :unprocessable_entity
    end
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
end
