class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :delete_all

  
  scope :ordered, -> { order(id: :desc) }
end
