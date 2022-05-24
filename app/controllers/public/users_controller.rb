class Public::UsersController < ApplicationController
  def show
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    redirect_to my_page_path
  end

  def posts
    @myposts = Post.where(user_id: current_user.id)
  end

  def likes
    likes = Like.where(user_id: current_user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

  def unsubscribe
    @user = User.find(current_user.id)
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
