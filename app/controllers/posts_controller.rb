class PostsController < ApplicationController
  def index
    dashboard = Dashboard.new(tumblr.dashboard)
    @posts = dashboard.posts
  end

  def new
  end

  def create
    user = TumblrUser.new(tumblr.user_info)
    blog = user.blogs.first
    tumblr.post(params[:body], blog.name)
    redirect_to user_path(current_user)
  end
end

