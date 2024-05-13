class Relationship < ApplicationRecord
    belongs_to :monitor, class_name: 'User', foreign_key: :monitor_id
    belongs_to :monitored, class_name: 'User', foreign_key: :monitored_id
end
