class Author < ApplicationRecord
  has_many :books

  scope :search, ->(search){where("name LIKE ?", "%#{search}%") if search}
  scope :_page, ->(page) do
    paginate(page: page, per_page: Settings.author.index.per_page)
  end

  def self.to_xls options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |author|
        csv << author.attributes.values_at(*column_names)
      end
    end
  end

  validates :name, presence: true
  validates :content, presence: true
end
