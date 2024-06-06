class StampedRecord < ApplicationRecord
  belongs_to :record
  belongs_to :stamp
end
