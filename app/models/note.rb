class Note < ApplicationRecord
  has_attached_file :upload
  has_many :scale_notes
  belongs_to :instrument

  validates :upload, attachment_presence: true
  validates_attachment :upload, content_type: {
    content_type: ["audio/mp3", "audio/x-mp3", "audio/mpeg3", "audio/x-mpeg-3", "video/mpeg-3", "video/x-mpeg", "audio/wav", "audio/x-wav"]
  }
end
