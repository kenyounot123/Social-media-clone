class PostsController < ApplicationController

  def index
    @posts = Post.ordered
  end

  def new
    @post = Post.new(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      respond_to do |format|
        format.html {
          flash[:notice] = 'Post successfully created'
          redirect_to @post
        }
        format.turbo_stream
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

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end