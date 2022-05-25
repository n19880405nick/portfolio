class Admin::PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = Tag.where(post_id: @post.id)
    @post_comments = @post.comments.all
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_top_path
  end
end
