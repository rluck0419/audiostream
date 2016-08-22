class NewCommentJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      "chat_#{room}",
      sent_by: 'Paul',
      body: message
    )
  end
end
