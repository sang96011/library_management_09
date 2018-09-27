class Publisher < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :address, presence: true
end
