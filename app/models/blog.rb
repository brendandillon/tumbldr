class Blog
  attr_reader :title, :url, :name

  def initialize(raw_blog)
    @title = raw_blog['title']
    @url = raw_blog['url']
    @name = raw_blog['name']
  end
end
