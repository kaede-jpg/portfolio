class StampedRecordsController < ApplicationController
  def create
    @stamped_record = StampedRecord.new(record_id: params[:record_id], stamp_id: params[:stamp_id])
    @stamped_record.save!
    set_stamps
  end

  private
  def set_stamps
    @stamps = Stamp.all
    @stamped_records = StampedRecord.where(record_id: params[:record_id], stamp_id: params[:stamp_id])
  end
end
