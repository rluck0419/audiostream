class KeyChangeChannel < ApplicationCable::Channel
  def subscribed
    puts "subscribed to key_change"
    stream_from "key_change"
  end

  def change
    current_user.key_change
  end

  # def receive(data)
  #   puts "broadcasting data to key_change"
  #   ActionCable.server.broadcast "appearance", data
  # end
end
