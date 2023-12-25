class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, length: { minimum: 2, maximum: 25}, on: :edit

  has_many :posts
  has_many :comments
  
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
end
