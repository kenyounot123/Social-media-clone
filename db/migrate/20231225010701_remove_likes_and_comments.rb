class RemoveLikesAndComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :likes
    remove_column :posts, :comments
  end
end
