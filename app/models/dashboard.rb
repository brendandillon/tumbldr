class Dashboard
  def initialize(raw_dashboard)
    @raw_posts = raw_dashboard
  end

  def posts
    @raw_posts.map do |raw_post|
      Post.new(raw_post)
    end
  end
end
