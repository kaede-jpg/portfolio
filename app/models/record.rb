class Record < ApplicationRecord
  has_one_attached :meal_image

  validates :meal_image, presence: true, blob: { content_type: :image }

  belongs_to :user, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stamped_records, dependent: :destroy
end
