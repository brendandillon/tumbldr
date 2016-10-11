class SessionsController < ApplicationController
  def create
    tumblr = TumblrService.new(session[:token], session[:token_secret])
    access_body = tumblr.access_token(params[:oauth_verifier])

    session[:token] = access_body.split(/\W+/)[1]
    session[:token_secret] = access_body.split(/\W+/)[3]

    updated_tumblr = TumblrService.new(session[:token], session[:token_secret])

    @info = updated_tumblr.info
  end
end
