class UserAppearJob < ApplicationJob
  queue_as :default

  def perform(user, datetime, notes)
    ActionCable.server.broadcast("appearance", user_id: user.id, user_email: user.email, notes: notes, type: "join", message: "#{user.email} is now logged in - #{datetime}")
  end
end
