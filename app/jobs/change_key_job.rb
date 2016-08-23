class ChangeKeyJob < ApplicationJob
  queue_as :default

  def perform(key, scale, notes)
    ActionCable.server.broadcast("key_change", notes: notes, message: "The music is now in the key of #{key.name} #{scale.name}.")
  end
end
