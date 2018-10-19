class Publisher < ApplicationRecord
  has_many :books

  scope :alphabet, ->{order name: :ASC}
  scope :newest, ->{order updated_at: :DESC}
  scope :_page, ->(page) do
    paginate(page: page, per_page: Settings.publisher.per_page)
  end

  def self.to_xls options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |publisher|
        csv << publisher.attributes.values_at(*column_names)
      end
    end
  end

  validates :name, presence: true
  validates :address, presence: true
end
