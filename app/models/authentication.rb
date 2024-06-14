class Authentication < ApplicationRecord
  belongs_to :user

  scope :line_of, ->(user) { user.authentications.find_by(provider: 'line') }
end
