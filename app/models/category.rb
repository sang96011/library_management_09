class Category < ApplicationRecord
  has_many :books

  scope :alphabet, ->{order name: :ASC}
  scope :search, -> query {where("name LIKE ?", "%#{query}%") if query.present?}

  validates :name, presence: true
  validates :parent_id, presence: true
end
