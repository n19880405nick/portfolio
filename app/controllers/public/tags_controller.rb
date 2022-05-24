class Public::TagsController < ApplicationController

  def search
    @tag = Tag.find(params[:tag_id])
    @records = Post.where(['contribution LIKE ?','%'+@tag.tag+'%'])
  end

end
