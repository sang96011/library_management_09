class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and
  devise :database_authenticatable, :registerable, :confirmable, :recoverable,
    :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :likes, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :user_reviews, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save{email.downcase!}

  scope :newest, ->{order created_at: :DESC}
  scope :_page, -> page do
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

 def self.from_omniauth(auth)
    data = auth.info
    user = User.where(email: data["email"]).first
    unless user
      password = Devise.friendly_token[0,20]
      user = User.create!(name: data["name"], email: data["email"], password: password, password_confirmation: password, confirmed_at: DateTime.now)
    end
    user
  end

  validates :name, presence: true,
    length: {maximum: Settings.user.name.max_length}
  validates :email, presence: true,
    length: {maximum: Settings.user.email.max_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

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

  def follow? target
    follows.find_by target: target
  end

  def review? book
    user_reviews.find_by book_id: book. id
  end
end
