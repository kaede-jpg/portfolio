class Record < ApplicationRecord
  has_one_attached :meal_image

  validates :meal_image, presence: true, blob: { content_type: :image }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :stamped_records, dependent: :destroy

  def each_score
    sum = 0
    count = 0
    stamped_records
      .joins(:stamp)
      .group('stamps.score')
      .count
      .each do |key, value|
        sum += key.to_i * value
        count += value
      end
    count.zero? ? 0 : sum / count
  end
end
