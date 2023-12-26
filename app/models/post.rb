class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :delete_all
  
  has_many :likes
  has_many :liking_users, through: :likes, source: :user
  
  scope :ordered, -> { order(id: :desc) }
end
