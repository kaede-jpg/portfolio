class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :record

  validates :body, presence: true
end
