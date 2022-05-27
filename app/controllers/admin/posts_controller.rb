class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all.order("created_at DESC")
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
