class User < ApplicationRecord
  authenticates_with_sorcery!

  before_update :setup_activation, if: -> { email_changed? }
  after_update :send_activation_needed_email!, if: -> { previous_changes['email'].present? }

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_one :relationship, foreign_key: :monitor_id, dependent: :destroy, inverse_of: :monitor
  has_many :relationships, foreign_key: :monitored_id, dependent: :destroy, inverse_of: :monitored

  has_many :records, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  validates :activation_token, presence: true, uniqueness: true, allow_nil: true
  validates :agreement, acceptance: { allow_nil: false, on: :create }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  validates :relationship_code, uniqueness: true, allow_nil: true

  enum role: { monitor: 0, monitored: 1 }
  validate :role_change_restriction

  scope :monitored_by, ->(user) { find(user.relationship.monitored_id) }
  scope :monitors_of, ->(user) { where(id: user.relationships.pluck(:monitor_id)) }

  # 連携済か判定する
  def related?
    relationship || relationships.exists?
  end

  # LINE連携済か判定する
  def linked_line?
    authentications.exists? && Authentication.line_of(self).present?
  end

  private

  def role_change_restriction
    return unless role_changed? && related?

    errors.add(:role, I18n.t('alert.related_user'))
  end
end
