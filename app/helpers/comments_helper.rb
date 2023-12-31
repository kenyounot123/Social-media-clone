module CommentsHelper
  def find_username(user_id)
    User.find(user_id).name
  end
  
  def post_for_this_comment(comment)
    Post.find(comment.commentable_id)
  end
end
