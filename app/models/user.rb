class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_one :relationship, foreign_key: :monitor_id, dependent: :destroy, inverse_of: :monitor
  has_many :relationships, foreign_key: :monitored_id, dependent: :destroy, inverse_of: :monitored

  has_many :records, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :user_id, uniqueness: true
  validates :user_id, presence: true, unless: :new_record?

  validates :relationship_digest, uniqueness: true, allow_nil: true

  enum role: { monitor: 0, monitored: 1 }
  validate :role_change_restriction

  scope :monitored_by, ->(user) { find(user.relationship.monitored_id) }
  scope :monitors_of, ->(user) { where(id: user.relationships.pluck(:monitor_id)) }

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

  # 連携済か判定する
  def related?
    relationship || relationships.exists?
  end

  # LINE連携済か判定する
  def linked_line?
    authentications && Authentication.line_of(self)
  end

  private

  def role_change_restriction
    return unless role_changed? && related?

    errors.add(:role, 'は連携されているため変更できません')
  end
end
