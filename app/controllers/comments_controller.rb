class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.commentable_id)
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment updated"
    else
      render :edit, notice: "Something went wrong, comment was not updated"
    end
  end

  def show
    @comment = Comment.find(params[:id])
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

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Comment successfully deleted' }
      format.turbo_stream {
        render turbo_stream: turbo_stream.remove("comment_#{@comment.id}")
      }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
