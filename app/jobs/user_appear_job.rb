class UserAppearJob < ApplicationJob
  queue_as :default

  def perform(user, datetime)
    ActionCable.server.broadcast("appearance", message: "#{user.email} is now logged in - #{datetime}")
  end
end
