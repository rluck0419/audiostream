class ChangeKeyJob < ApplicationJob
  queue_as :default

  def perform(user, key, scale, notes)
    ActionCable.server.broadcast("key_change", user_email: user.email, key: key, notes: notes, message: "The music is now in the key of #{key.name} #{scale.name}.")
  end
end
