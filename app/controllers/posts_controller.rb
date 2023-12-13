class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new(post_params)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'Post successfully created'
      redirect_to @post
    else
      flash[:alert] = 'Post was not created'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:title, :body)
  end
end
