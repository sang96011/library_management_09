class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true

  validates :target_id, presence: true
  validates :target_type, presence: true
  validates :body, presence: true, allow_blank: false

  delegate :name, to: :user, prefix: :user
end
