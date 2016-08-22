class UserAppearJob < ApplicationJob
  queue_as :default

  def perform(user, datetime)
    ActionCable.server.broadcast("appearance", user: user.email, type: "join", message: "#{user.email} is now logged in - #{datetime}")
  end
end
