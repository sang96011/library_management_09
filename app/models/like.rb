class Like < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true

  validates :target_id, presence: true
  validates :target_type, presence: true
end
