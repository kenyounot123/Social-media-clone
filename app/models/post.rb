class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :delete_all
  has_one_attached :image
  has_many :likes
  has_many :liking_users, through: :likes, source: :user
  
  scope :ordered, -> { order(id: :desc) }
  #Gets posts made by users that the current user follows and also their own posts
  scope :following_and_own_posts, ->(user) { 
    where(user_id: [user.id] + user.followings.pluck(:id))
  }
  def liked_by?(user)
    likes.where(user: user).any?
  end

  def unlike(user)
    likes.where(user: user).destroy_all
  end

  def like(user)
    likes.where(user: user).first_or_create
  end
end
