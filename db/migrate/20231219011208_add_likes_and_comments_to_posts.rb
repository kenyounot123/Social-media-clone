class AddLikesAndCommentsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :likes, :bigint
    add_column :posts, :comments, :bigint
  end
end
