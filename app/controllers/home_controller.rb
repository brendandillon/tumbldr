class HomeController < ApplicationController
  def index
    tumblr = TumblrService.new(session[:token], session[:token_secret])
    request_body = tumblr.request_token
    token = request_body.split(/\W+/)[1]

    session[:token] = token
    session[:token_secret] = request_body.split(/\W+/)[3]

    redirect_to "https://www.tumblr.com/oauth/authorize?oauth_token=#{token}"
  end
end
