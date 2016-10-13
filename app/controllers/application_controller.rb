class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_name(session[:name])
  end

  def tumblr
    TumblrService.new(session[:token], session[:token_secret])
  end
end
