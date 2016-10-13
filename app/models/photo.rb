class Photo
  attr_reader :url, :caption

  def initialize(raw_photo)
    @url = raw_photo['alt_sizes'].first['url']
    @caption = raw_photo['caption']
  end
end
