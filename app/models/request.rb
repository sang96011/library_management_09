class Request < ApplicationRecord
  enum status: {reject: 0, accept: 1}
  belongs_to :user
  has_many :request_details, dependent: :destroy

  validates :from_day, presence: true
  validates :to_day, presence: true
end
