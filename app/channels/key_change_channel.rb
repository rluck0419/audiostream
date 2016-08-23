class KeyChangeChannel < ApplicationCable::Channel
  def subscribed
    # current_user.appear
    stream_from "key_change"
  end

  # def receive(data)
  #   puts "broadcasting data to key_change"
  #   ActionCable.server.broadcast "appearance", data
  # end
end
