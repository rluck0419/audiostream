class UserAwayJob < ApplicationJob
  queue_as :default
  
  def perform(user, datetime)
    ActionCable.server.broadcast(message: "#{user} is now away - #{datetime}")
  end
end
