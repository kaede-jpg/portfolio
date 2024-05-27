class Record < ApplicationRecord
    belongs_to :user
    has_one_attached :meal_image

    validates :user_id, presence: true
    validates :meal_image, presence: true, blob: { content_type: :image }
end
