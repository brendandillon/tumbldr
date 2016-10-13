class Message
  attr_reader :name,
              :label,
              :phrase

  def initialize(raw_message)
    @name = raw_message['name']
    @label = raw_message['label']
    @phrase = raw_message['phrase']
  end
end
