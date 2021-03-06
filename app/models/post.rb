class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 300 }
  validates_associated :images
  validates :images, presence: true

  def self.search(search)
    if search
      Post.where('title LIKE(?) OR content LIKE(?) OR hashbody LIKE(?) ', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      Post.all
    end
  end

  after_create do
    post = Post.find_by(id: id)
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.downcase.delete("#＃"))
      post.tags << tag
    end
  end

  before_update do
    post = Post.find_by(id: id)
    post.tags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.downcase.delete("#＃"))
      post.tags << tag
    end
  end

  def liked_by?(user)
    self.likes.where(user_id: user.id).exists?
  end
end
