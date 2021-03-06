class Book < ApplicationRecord
  belongs_to :author
  belongs_to :publisher
  belongs_to :category
  has_many :request_details, dependent: :destroy
  has_many :user_reviews, dependent: :destroy
  has_many :comments, as: :target, dependent: :destroy
  has_many :follows, as: :target, dependent: :destroy
  has_many :likes, as: :target, dependent: :destroy

  scope :search, -> search do
    joins(:author, :publisher, :category).
    where("books.name || categories.name || authors.name || publishers.name || books.status
      LIKE ?", "%#{search}%") if search
  end
  scope :_page, -> page do
    paginate(page: page, per_page: Settings.book.per_page)
  end

  validates :name, presence: true
  validates :content, :category, presence: true
  validates :number_page, presence: true
  validates :year, presence: true

  delegate :name, to: :author, prefix: :author
  delegate :name, to: :publisher, prefix: :publisher
  delegate :name, to: :category, prefix: :category
end
