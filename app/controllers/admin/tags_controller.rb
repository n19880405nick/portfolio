class Admin::TagsController < ApplicationController
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_post_path(tag.post_id)
  end
end
