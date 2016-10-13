class TumblrUser
  attr_reader :name

  def initialize(raw_user)
    @name = raw_user['name']
    @raw_blogs = raw_user['blogs']
  end

  def blogs
    @raw_blogs.map do |raw_blog|
      Blog.new(raw_blog)
    end
  end
end
