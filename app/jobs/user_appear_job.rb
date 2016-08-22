class UserAppearJob < ApplicationJob
  queue_as :default

  def perform(user, datetime)
    ActionCable.server.broadcast(message: "#{user} is now logged in - #{datetime}")
  end
end
