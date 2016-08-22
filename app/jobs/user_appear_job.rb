class UserAppearJob < ApplicationJob
  queue_as :default

  def perform(user, datetime)
    ActionCable.server.broadcast("appearance", user_id: user.id, user_email: user.email, type: "join", message: "#{user.email} is now logged in - #{datetime}")
  end
end
