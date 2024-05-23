class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_one :relationship, foreign_key: :monitor_id, dependent: :destroy, inverse_of: :monitor
  has_many :relationships, foreign_key: :monitored_id, dependent: :destroy, inverse_of: :monitored

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :user_id, uniqueness: true
  validates :user_id, presence: true, unless: :new_record?

  validates :invitation_digest, uniqueness: true, allow_nil: true
  enum invitation_my_role: { monitor: 0, monitored: 1 }

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end
end
