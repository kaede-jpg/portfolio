class RecordsController < ApplicationController
  before_action :set_record, only: %i[destroy]

  def index
    @comment = current_user.comments.build
    set_partner
    if @monitored
      @records = Record.where(user_id: @monitored.id).includes(comments: :user)
      @message = "#{@monitored.name}さんを監視しています"
    elsif @monitor
      @records = current_user.records.includes(comments: :user)
      @message = "#{@monitor.map(&:name).join('さん、 ')}さんに監視されています"
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

  def set_partner
    if current_user.relationship
      @monitored = User.find_by(id: current_user.relationship.monitored_id)
    elsif current_user.relationships.exists?
      @monitor = User.where(id: current_user.relationships.pluck(:monitor_id))
    else
      @monitored = nil
      @monitor = nil
    end
  end
end
