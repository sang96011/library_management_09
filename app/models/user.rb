class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password

  has_many :likes, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :resquests, dependent: :destroy
  has_many :user_reviews, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save{email.downcase!}

  scope :search, ->(query){where("name LIKE ?", "%#{query}%") if query.present?}
  scope :newest, ->{order created_at: :DESC}
  scope :_page, ->(page) do
    paginate(page: page, per_page: Settings.publisher.per_page)
  end

  def self.to_xls options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

  validates :name, presence: true,
    length: {maximum: Settings.user.name.max_length}
  validates :email, presence: true,
    length: {maximum: Settings.user.email.max_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.user.pass.min_length}

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def like? book
    likes.find_by target: book
  end

  def follow! book
    follows.create! book_id: book.id
  end

  def unfollow! book
    follow = follows.find_by id: book.id
    follow.destroy!
  end

  def follow? book
    follows.find_by target_id: book.id
  end

end
