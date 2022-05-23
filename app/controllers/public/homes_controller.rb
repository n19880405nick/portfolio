class Public::HomesController < ApplicationController
  def top
  end

  def search
    @records = Post.search_for(params[:keyword])
    @keyword = params[:keyword]
  end
end
