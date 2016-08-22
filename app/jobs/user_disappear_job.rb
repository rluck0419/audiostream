class UserDisappearJob < ApplicationJob
  queue_as :default

  def perform(user)
    ActionCable.server.broadcast("appearance", user_id: user.id, user_email: user.email, type: "leave", message: "#{user.email} has left")
  end
end
