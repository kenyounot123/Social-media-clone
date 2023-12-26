class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Gravtastic
  gravtastic :secure => true,
              :size => 50,
              :default => "monsterid"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]
  validates :name, length: { minimum: 2, maximum: 25}, on: :edit

  has_many :posts
  has_many :comments
  
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  has_many :follows
  has_many :followers, through: :follows, source: :user

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end
end
