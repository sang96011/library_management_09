class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true

  scope :of_author, -> author{where(target: author)}

  validates :target_id, presence: true
  validates :target_type, presence: true
end
