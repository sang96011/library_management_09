class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :target_id
  belongs_to :target_type

  validates :target_id, presence: true
  validates :target_type, presence: true
end
