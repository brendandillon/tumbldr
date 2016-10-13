class UsersController < ApplicationController
  def show
    user = TumblrUser.new(tumblr.user_info)
    @avatar = tumblr.avatar(user.blogs.first.name)
  end
end
