class ChangeKeyJob < ApplicationJob
  queue_as :default

  def perform(key, scale)
    ActionCable.server.broadcast("key_change", message: "The music is now in the key of #{key.name} #{scale.name}.")
  end
end
