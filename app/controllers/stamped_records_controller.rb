class StampedRecordsController < ApplicationController
  def create
    @stamped_record = StampedRecord.new(record_id: params[:record_id], stamp_id: params[:stamp_id])
    unless @stamped_record.save
      render status: :unprocessable_entity
    end
  end
end
