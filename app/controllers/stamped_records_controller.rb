class StampedRecordsController < ApplicationController
  def create
    @stamped_record = StampedRecord.new(record_id: params[:record_id], stamp_id: params[:stamp_id])
    if @stamped_record.save
      @stamped_records = StampedRecord.where(record_id: params[:record_id], stamp_id: params[:stamp_id])
    else
      render status: :unprocessable_entity
    end
  end
end
