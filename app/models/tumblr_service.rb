class TumblrService
  def initialize(token, secret)
    @token = token
    @secret = secret
  end

  def request_token
    post_url = OauthUrl.new('post', 'https://www.tumblr.com/oauth/request_token')
    response = Faraday.post(post_url.url)
    
    return response.body
  end

  def access_token(verifier)
    url = OauthUrl.new('post', 'https://www.tumblr.com/oauth/access_token', @token, @secret, verifier)
    response = Faraday.post(url.access_url)

    return response.body
  end

  def info
    info_url = OauthUrl.new('get', 'https://api.tumblr.com/v2/user/info', @token, @secret)
    oauth_response = Faraday.get(info_url.request_url)
    JSON.parse(oauth_response.body)
  end
end
