class Author < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :content, presence: true
end
