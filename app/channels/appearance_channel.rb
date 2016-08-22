class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    # current_user.appear
    stream_from "appearance"
  end

  def unsubscribed
    current_user.disappear
  end

  def appear(data)
    current_user.appear(on: data['appearing_on'])
  end

  def away
    current_user.away
  end

  # def receive(data)
  #   puts "broadcasting data to appearance"
  #   ActionCable.server.broadcast "appearance", data
  # end
end
