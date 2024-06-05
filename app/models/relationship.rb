class Relationship < ApplicationRecord
  belongs_to :monitor, class_name: 'User'
  belongs_to :monitored, class_name: 'User'

  validates :monitor_id, uniqueness: true
  validate :monitor_cannot_set_exceeded_limit
  validate :cannot_set_circular_relationship

  MONITOR_MAX_COUNT = 3
  def monitor_cannot_set_exceeded_limit
    return unless Relationship.where(monitored_id:).count >= MONITOR_MAX_COUNT

    errors.add(:monitored_id, ': 監視者に設定できるのは、3名までです')
  end

  def cannot_set_circular_relationship
    errors.add(:monitored_id, ': 既に監視される側に設定されています') if Relationship.exists?(monitor_id: monitored_id)

    return unless Relationship.exists?(monitored_id: monitor_id)

    errors.add(:monitor_id, ': 既に監視者に設定されています')
  end
end
