class LikesController < ApplicationController
  def update
    @post = Post.find(params[:id])
    if @post.liked_by?(current_user)
      @post.unlike(current_user)
    else
      @post.like(current_user)
    end

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(dom_id(@post, :likes), partial: 'likes/likes', locals: { post: @post })
      }
    end
  end

end
