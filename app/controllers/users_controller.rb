class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboard_path, notice: "Profile updated"
    else
      render :edit, notice: "Something went wrong, profile was not updated"
    end
  end

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.all.ordered)
    @comment_slice = true
  end

  def following
    @user = User.find(params[:id])
    @pagy, @following = pagy(@user.followings.all)
  end

  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers.all)
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
