class BlogsController < ApplicationController
  def index
    user = TumblrUser.new(tumblr.user_info)
    @blogs = user.blogs
  end
end
