class RequestDetail < ApplicationRecord
  belongs_to :request
  belongs_to :book

  scope :of_request, -> id {where request_id: id}

  validates :number, presence: true
end
