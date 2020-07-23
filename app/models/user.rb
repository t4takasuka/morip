class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  mount_uploader :image, ImageUploader
  
  # ↓フォローモデル
  has_many :relationships
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :profile, length: { maximum: 200 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 6 }, allow_blank: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true

  def self.guest
    find_or_create_by(email: 'test@example.com') do |user|
      user.name = "testさん"
      user.profile = "よろしくお願いします。"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end
end
