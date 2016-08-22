class UserDisappearJob < ApplicationJob
  queue_as :default

  def perform(user, datetime)
    ActionCable.server.broadcast(

      message: "#{user} has logged out - #{datetime}")
  end
end
