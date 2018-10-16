class Request < ApplicationRecord
  enum status: {reject: 0, accept: 1}

  belongs_to :user
  has_many :request_details, dependent: :destroy

  before_create :set_day

  scope :newest, ->{order created_at: :DESC}
  scope :of_user, -> id {where user_id: id}

  def total_book
    request_details.map{|rd| rd.valid? ? rd.number : 0}.sum
  end

  def set_day
    self.from_day = Time.now
    self.to_day = self.from_day + 7.days
  end
end
