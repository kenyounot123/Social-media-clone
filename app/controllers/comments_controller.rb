class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user.id
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = @user

    if @comment.save 
      respond_to do |format|
        format.html {
          redirect_to dashboard_path, notice: 'Comment successfully created'
        }
        format.turbo_stream
      end
    else
      flash[:alert] = 'Something went wrong when trying to comment'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
