require 'cgi'
require 'base64'
require 'openssl'

class OauthUrl
  CONSUMER_KEY = Figaro.env.oauth_consumer_key
  SIGNATURE_METHOD = 'HMAC-SHA1'
  VERSION = '1.0'
  SECRET_KEY = Figaro.env.oauth_secret_key + '&'

  def initialize(verb, url)
    @url = url
    @verb = verb.upcase
    @timestamp = Time.now.to_i.to_s
    @nonce = Random.rand(100000).to_s
  end

  def parameters
    "oauth_consumer_key=#{CONSUMER_KEY}&oauth_nonce=#{@nonce}&oauth_signature_method=#{SIGNATURE_METHOD}&oauth_timestamp=#{@timestamp}&oauth_version=#{VERSION}"
  end

  def base_string
    "#{@verb}&#{CGI.escape(@url)}&#{CGI.escape(parameters)}"
  end

  def signature
    CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1',SECRET_KEY,base_string)}").chomp)
  end

  def url
    "#{@url}?#{parameters}&oauth_signature=#{signature}"
  end
end
