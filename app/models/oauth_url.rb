require 'cgi'
require 'base64'
require 'openssl'

class OauthUrl
  CONSUMER_KEY = Figaro.env.oauth_consumer_key
  SIGNATURE_METHOD = 'HMAC-SHA1'
  VERSION = '1.0'

  def initialize(verb, url, token = nil, token_secret = "", verifier = nil, before_params = "", after_params = "")
    @url = url
    @verb = verb.upcase
    @timestamp = Time.now.to_i.to_s
    @nonce = Random.rand(100000).to_s
    @token = token
    @verifier = verifier
    @secret_key = Figaro.env.oauth_secret_key + '&' + token_secret
    @before_params = before_params
    @after_params = after_params
  end

  def parameters
    "oauth_consumer_key=#{CONSUMER_KEY}&oauth_nonce=#{@nonce}&oauth_signature_method=#{SIGNATURE_METHOD}&oauth_timestamp=#{@timestamp}&oauth_version=#{VERSION}"
  end

  def base_string
    "#{@verb}&#{CGI.escape(@url)}&#{CGI.escape(parameters)}"
  end

  def signature
    CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1',@secret_key,base_string)}").chomp)
  end

  def url
    "#{@url}?#{parameters}&oauth_signature=#{signature}"
  end
  
  def access_parameters
    "oauth_consumer_key=#{CONSUMER_KEY}&oauth_nonce=#{@nonce}&oauth_signature_method=#{SIGNATURE_METHOD}&oauth_timestamp=#{@timestamp}&oauth_token=#{@token}&oauth_verifier=#{@verifier}&oauth_version=#{VERSION}"
  end

  def access_base_string
    "#{@verb}&#{CGI.escape(@url)}&#{CGI.escape(access_parameters)}"
  end

  def access_signature
    CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1',@secret_key,access_base_string)}").chomp)
  end

  def access_url
    "#{@url}?#{access_parameters}&oauth_signature=#{access_signature}"
  end

  def request_parameters
    @before_params + "oauth_consumer_key=#{CONSUMER_KEY}&oauth_nonce=#{@nonce}&oauth_signature_method=#{SIGNATURE_METHOD}&oauth_timestamp=#{@timestamp}&oauth_token=#{@token}&oauth_version=#{VERSION}" + @after_params
  end

  def request_base_string
    "#{@verb}&#{CGI.escape(@url)}&#{CGI.escape(request_parameters)}"
  end

  def request_signature
    CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1',@secret_key,request_base_string)}").chomp)
  end

  def request_url
    "#{@url}?#{request_parameters}&oauth_signature=#{request_signature}"
  end

  def post_parameters
    "oauth_consumer_key=#{CONSUMER_KEY}&oauth_nonce=#{@nonce}&oauth_signature_method=#{SIGNATURE_METHOD}&oauth_timestamp=#{@timestamp}&oauth_token=#{@token}&oauth_version=#{VERSION}"
  end

  def post_base_string
    "#{@verb}&#{CGI.escape(@url)}&#{CGI.escape(post_parameters)}"
  end

  def post_signature
    CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1',@secret_key,post_base_string)}").chomp)
  end

  def post_url
    "#{@url}?#{post_parameters}&oauth_signature=#{request_signature}"
  end
end
