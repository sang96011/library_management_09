class UserReview < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, presence: true
  validates :content, presence: true
  validates :rate, presence: true
end
