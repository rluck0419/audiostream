class Scale < ApplicationRecord
  has_many :scale_notes
  has_many :notes, through: :scale_notes

  def key_notes(key)
    notes.where(scale_notes: { key_id: k })
  end
end
