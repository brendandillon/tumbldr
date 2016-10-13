class SessionsController < ApplicationController
  def create
    access_body = tumblr.access_token(params[:oauth_verifier])

    session[:token] = access_body.split(/\W+/)[1]
    session[:token_secret] = access_body.split(/\W+/)[3]

    @user = TumblrUser.new(tumblr.user_info)

    user = User.find_or_create_by(name: @user.name) 
    user.token = session[:token]
    user.token_secret = session[:token_secret]

    session[:name] = user.name

    redirect_to user_path(user, user: @user)
  end
end
