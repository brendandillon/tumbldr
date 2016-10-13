class ReblogsController < ApplicationController
  def new
    user = TumblrUser.new(tumblr.user_info)
    blog = user.blogs.first
    tumblr.reblog(params[:post_id], params[:reblog_key], blog.name)
    redirect_to request.referrer
  end
end
