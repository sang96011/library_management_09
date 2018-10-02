class Author < ApplicationRecord
  has_many :books

  scope :search, -> search {where("name LIKE ?", "%#{search}%") if search}
  scope :_page, -> page do
    paginate(page: page, per_page: Settings.author.index.per_page)
  end

  validates :name, presence: true
  validates :content, presence: true
end
