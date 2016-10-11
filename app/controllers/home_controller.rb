class HomeController < ApplicationController
  def index
    post_url = OauthUrl.new('post', 'https://www.tumblr.com/oauth/request_token')
    response = Faraday.post(post_url.url)
    token = response.body.split(/\W+/)[1]
    redirect_to "https://www.tumblr.com/oauth/authorize?oauth_token=#{token}"
  end
end
