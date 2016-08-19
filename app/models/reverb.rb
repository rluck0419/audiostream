class Reverb < ApplicationRecord
  has_attached_file :upload
  has_many :user_reverbs

  validates :upload, attachment_presence: true
  validates_attachment :upload, content_type: {
    content_type: ["audio/mp3", "audio/x-mp3", "audio/mpeg3", "audio/x-mpeg-3", "video/mpeg-3", "video/x-mpeg", "audio/wav", "audio/x-wav"]
  }
end
