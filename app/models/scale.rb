class Scale < ApplicationRecord
  has_many :scale_notes
  has_many :notes, through: :scale_notes
  has_many :instruments, through: :notes
  has_many :user_scales

  def key_notes(key)
    notes.where(scale_notes: { key_id: key })
  end
end
