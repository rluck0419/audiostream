class UserDisappearJob < ApplicationJob
  queue_as :default

  def perform(user)
    ActionCable.server.broadcast("appearance", message: "#{user.email} has logged out")
  end
end
