class Player
  attr_reader :embed_code

  def initialize(raw_player)
    @embed_code = raw_player.first['embed_code']
  end
end
