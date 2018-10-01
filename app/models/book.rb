class Book < ApplicationRecord
  belongs_to :author
  belongs_to :publisher
  belongs_to :category
  has_many :request_details, dependent: :destroy
  has_many :user_reviews, dependent: :destroy

  validates :name, presence: true
  validates :content, presence: true
  validates :number_page, presence: true
  validates :year, presence: true
end
