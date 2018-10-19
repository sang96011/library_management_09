class Category < ApplicationRecord
  has_many :books

  scope :alphabet, ->{order name: :ASC}

  validates :name, presence: true
  validates :parent_id, presence: true
end
