class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

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
