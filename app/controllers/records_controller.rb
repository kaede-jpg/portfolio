class RecordsController < ApplicationController
  before_action :set_record, only: %i[ destroy ]

  def index
    @records = Record.all
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params.merge(user_id: current_user.id))
      if @record.save
        redirect_to records_path, notice: "Record was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy!
    redirect_to records_path, notice: "Record was successfully destroyed."
  end

  private

    def record_params
      params.require(:record).permit(:meal_image)
    end
  
end
