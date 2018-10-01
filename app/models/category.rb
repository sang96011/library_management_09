class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :parent_id, presence: true
  validates :path, presence: true
end
