class RecordsController < ApplicationController
  def index
    @comment = current_user.comments.build
    if current_user.related?
      if current_user.monitor?
        monitored = User.find_by(id: current_user.relationship.monitored_id)
        @records = Record.where(user_id: monitored.id).includes(comments: :user)
        @message = "#{monitored.name}さんを監視しています"
      else
        monitors = User.where(id: current_user.relationships.pluck(:monitor_id))
        @records = current_user.records.includes(comments: :user)
        @message = "#{monitors.map(&:name).join('さん、 ')}さんに監視されています"
      end
    else
      @records = []
      @message = '連携されていません！'
    end
  end

  def new
    @record = current_user.records.build
  end

  def create
    @record = current_user.records.build(record_params)
    if @record.save
      redirect_to records_path, notice: 'Record was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @record = current_user.records.find(params[:id])
    @record.destroy!
    redirect_to records_path, notice: 'Record was successfully destroyed.'
  end

  private

  def record_params
    params.require(:record).permit(:meal_image)
  end
end
