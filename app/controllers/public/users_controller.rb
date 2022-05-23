class Public::UsersController < ApplicationController
  def show
  end

  def edit
  end

  def update
  end

  def posts
  end

  def likes
    likes = Like.where(user_id: current_user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

  def unsubscribe
  end

  def withdraw
  end

end
