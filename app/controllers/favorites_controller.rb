class FavoritesController < ApplicationController
  def new
    tumblr.like(params[:post_id], params[:reblog_key])
    redirect_to request.referrer
  end
end
