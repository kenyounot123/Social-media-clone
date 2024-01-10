class CommentsController < ApplicationController
  before_action :find_commentable, only: [:create, :new, :update]

  #For reply form
  def new
    @comment = @commentable
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @post = @commentable
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
    # @comment = @post.comments.build(comment_params)
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = @user

    if @comment.save && @comment.commentable_type == 'Post' 
      @post = Post.find(params[:post_id])
      respond_to do |format|
        format.html {
          redirect_to dashboard_path, notice: 'Comment successfully created'
        }
        format.turbo_stream
      end
    elsif @comment.save && @comment.commentable_type == 'Comment'
      respond_to do |format|
        format.html {
          redirect_to dashboard_path, notice: 'Comment successfully created'
        }
        format.turbo_stream {
          render turbo_stream: turbo_stream.append("replies_for_comment_#{@comment.commentable_id}", 
                                                  partial: 'comments/reply',
                                                  locals: { comment: @comment } )
        }
      end
    else
      flash[:alert] = 'Comment can not be empty'
      #Redirect back to previous page where request originated or dashboard path if not available
      redirect_to request.referer || dashboard_path, status: :unprocessable_entity
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
    params.require(:comment).permit(:content, :comment_id, :commentable_id)
  end

  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find_by_id(params[:comment_id])
    elsif params[:post_id]
      @commentable = Post.find_by_id(params[:post_id])
    end
  end

end