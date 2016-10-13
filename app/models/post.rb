class Post
  attr_reader :id,
              :reblog_key,
              :blog_name, 
              :date, 
              :state, 
              :type, 
              :caption,
              :title,
              :body,
              :text,
              :source

  def initialize(raw_post)
    @id = raw_post['id']
    @reblog_key = raw_post['reblog_key']
    @blog_name = raw_post['blog_name']
    @date = raw_post['date']
    @state = raw_post['state']
    @type = raw_post['type']
    @raw_photos = raw_post['photos']
    @caption = raw_post['caption']
    @title = raw_post['title']
    @body = raw_post['body']
    @text = raw_post['text']
    @source = raw_post['source']
    @raw_messages = raw_post['dialogue']
    @raw_player = raw_post['player']
  end

  def photos
    @raw_photos.map do |raw_photo|
      Photo.new(raw_photo)
    end
  end
          
  def player
    Player.new(@raw_player)
  end
  
  def messages
    @raw_messages.map do |raw_message|
      Message.new(raw_message)
    end
  end
end
