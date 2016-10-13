require 'URI'

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

  def user_info
    url = OauthUrl.new('get', 'https://api.tumblr.com/v2/user/info', @token, @secret)
    oauth_response = Faraday.get(url.request_url)
    JSON.parse(oauth_response.body)['response']['user']
  end

  def avatar(username)
    url = OauthUrl.new('get', "https://api.tumblr.com/v2/blog/#{username}.tumblr.com/avatar")
    oauth_response = Faraday.get(url.request_url)
    JSON.parse(oauth_response.body)['response']['avatar_url']
  end
  
  def dashboard
    url = OauthUrl.new('get', 'https://api.tumblr.com/v2/user/dashboard', @token, @secret)
    oauth_response = Faraday.get(url.request_url)
    JSON.parse(oauth_response.body)['response']['posts']
  end

  def like(post_id, reblog_key)
    url = OauthUrl.new('post', 'https://api.tumblr.com/v2/user/like', @token, @secret, nil, "id=#{post_id}&", "&reblog_key=#{reblog_key}")
    oauth = Faraday.post(url.request_url)
  end

  def reblog(post_id, reblog_key, blog_name)
    url = OauthUrl.new('post', "https://api.tumblr.com/v2/blog/#{blog_name}.tumblr.com/post/reblog", @token, @secret, nil, "id=#{post_id}&", "&reblog_key=#{reblog_key}")
    oauth = Faraday.post(url.request_url)
  end

  def post(body, blog_name)
    encoded_body = URI.escape(body)
    url = OauthUrl.new('post', "https://api.tumblr.com/v2/blog/#{blog_name}.tumblr.com/post", @token, @secret, nil, "body=#{encoded_body}&")

    conn = Faraday.new(:url => url.post_url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    
    conn.post '', {body: body} 
  end
end
