module CommentsHelper
  def find_username(user_id)
    User.find(user_id).name
  end
end
