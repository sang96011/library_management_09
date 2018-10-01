class Comment < ApplicationRecord
  belongs_to :user

  validates :target_id, presence: true
  validates :target_type, presence: true
end
