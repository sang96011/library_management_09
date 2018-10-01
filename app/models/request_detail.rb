class RequestDetail < ApplicationRecord
  belongs_to :request
  belongs_to :book

  validates :number, presence: true
end
