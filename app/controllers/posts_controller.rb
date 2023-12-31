class PostsController < ApplicationController

  def index
    @pagy, @posts = pagy(Post.ordered.following_and_own_posts(current_user))
    @comment_slice = true
  end

  def new
    @post = Post.new(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comment_slice = false
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      respond_to do |format|
        format.html {
          flash[:notice] = 'Post successfully created'
          redirect_to @post
        }
        format.turbo_stream {
        }
      end
    else
      flash[:alert] = 'Something went wrong'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update 
    @post = Post.find(params[:id])
    if post.update(post_params)
      flash[:notice] = 'Post updated successfully'
      redirect_to @post
    else
      render :edit, :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Post successfully deleted' }
      format.turbo_stream 
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
