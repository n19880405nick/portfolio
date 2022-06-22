class Public::UsersController < ApplicationController
  def show
    now = Date.current
    @before_prev_month = now.ago(2.month)
    before_prev_month_first_day = @before_prev_month.beginning_of_month.day
    before_prev_month_last_day = @before_prev_month.end_of_month.day
    @before_prev_month_days = (before_prev_month_first_day..before_prev_month_last_day).to_a
    if @before_prev_month.beginning_of_month.wday == 1
      @before_prev_month_days.unshift(" ")
    elsif @before_prev_month.beginning_of_month.wday == 2
      @before_prev_month_days.unshift(" ", " ")
    elsif @before_prev_month.beginning_of_month.wday == 3
      @before_prev_month_days.unshift(" ", " ", " ")
    elsif @before_prev_month.beginning_of_month.wday == 4
      @before_prev_month_days.unshift(" ", " ", " ", " ")
    elsif @before_prev_month.beginning_of_month.wday == 5
      @before_prev_month_days.unshift(" ", " ", " ", " ", " ")
    elsif @before_prev_month.beginning_of_month.wday == 6
      @before_prev_month_days.unshift(" ", " ", " ", " ", " ", " ")
    end
    @prev_month = now.prev_month
    prev_month_first_day = @prev_month.beginning_of_month.day
    prev_month_last_day = @prev_month.end_of_month.day
    @prev_month_days = (prev_month_first_day..prev_month_last_day).to_a
    if @prev_month.beginning_of_month.wday == 1
      @prev_month_days.unshift(" ")
    elsif @prev_month.beginning_of_month.wday == 2
      @prev_month_days.unshift(" ", " ")
    elsif @prev_month.beginning_of_month.wday == 3
      @prev_month_days.unshift(" ", " ", " ")
    elsif @prev_month.beginning_of_month.wday == 4
      @prev_month_days.unshift(" ", " ", " ", " ")
    elsif @prev_month.beginning_of_month.wday == 5
      @prev_month_days.unshift(" ", " ", " ", " ", " ")
    elsif @prev_month.beginning_of_month.wday == 6
      @prev_month_days.unshift(" ", " ", " ", " ", " ", " ")
    end
    first_day = now.beginning_of_month.day
    last_day = now.end_of_month.day
    @days = (first_day..last_day).to_a
    if now.beginning_of_month.wday == 1
      @days.unshift(" ")
    elsif now.beginning_of_month.wday == 2
      @days.unshift(" ", " ")
    elsif now.beginning_of_month.wday == 3
      @days.unshift(" ", " ", " ")
    elsif now.beginning_of_month.wday == 4
      @days.unshift(" ", " ", " ", " ")
    elsif now.beginning_of_month.wday == 5
      @days.unshift(" ", " ", " ", " ", " ")
    elsif now.beginning_of_month.wday == 6
      @days.unshift(" ", " ", " ", " ", " ", " ")
    end
    @calendar = Calendar.new
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
