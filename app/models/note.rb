class Note < ApplicationRecord
  has_attached_file :upload, s3_protocol: :https
  has_many :scale_notes
  belongs_to :instrument

  validates :upload, attachment_presence: true
  validates_attachment :upload, content_type: {
    content_type: ["audio/mp3", "audio/x-mp3", "audio/mpeg3", "audio/x-mpeg-3", "video/mpeg-3", "video/x-mpeg", "audio/wav", "audio/x-wav"]
  }

  def upload_url
    self.upload.try(:url)
  end

  def as_json(_ = nil)
    super(methods: [:upload_url])
  end
end
