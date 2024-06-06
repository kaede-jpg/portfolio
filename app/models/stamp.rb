class Stamp < ApplicationRecord
    has_one_attached :stamp_image

    validates :stamp_image, presence: true, blob: { content_type: :image }

    has_many :stamped_records, dependent: :destroy
end
