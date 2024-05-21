class Relationship < ApplicationRecord
    belongs_to :monitor, class_name: 'User', foreign_key: :monitor_id
    belongs_to :monitored, class_name: 'User', foreign_key: :monitored_id

    validates :monitor_id, presence: true, uniqueness: true
    validates :monitored_id, presence: true
    validate :monitor_cannot_set_exceeded_limit
    validate :cannot_set_circular_relationship

    MONITOR_MAX_COUNT = 3
    def monitor_cannot_set_exceeded_limit
        if Relationship.where(monitored_id: monitored_id).count >= MONITOR_MAX_COUNT
            errors.add(:monitored_id, ": 監視者に設定できるのは、3名までです")
        end
    end
    def cannot_set_circular_relationship
        if Relationship.where(monitor_id: monitored_id).exists?
          errors.add(:monitored_id, ": 既に監視される側に設定されています")
        end
    
        if Relationship.where(monitored_id: monitor_id).exists?
          errors.add(:monitor_id, ": 既に監視者に設定されています")
        end
    end
end
