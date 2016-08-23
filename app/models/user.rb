class User < ApplicationRecord
  has_secure_password
  has_many :user_instruments
  has_many :instruments, through: :user_instruments

  has_many :user_chords
  has_many :chords, through: :user_chords

  has_many :user_scales
  has_many :scales, through: :user_scales

  has_many :user_reverbs
  has_many :reverbs, through: :user_reverbs

  def appear(datetime = {})
    self.appearing_on = datetime[:on] || Time.zone.now
    self.save
    UserAppearJob.perform_now(self, self.appearing_on)
  end

  def disappear
    self.appearing_on = nil
    self.save
    UserDisappearJob.perform_now(self)
  end

  def key_change
    key = Key.all.sample
    scale = self.scales.sample
    notes = MusicTheory.notes_in_key_and_scale(key.name, scale)
    instrument = self.instruments.sample
    all_notes = Note.where(instrument: instrument)
    output_notes = []

    all_notes.each do |note|
      if notes.include?(note.name)
        output_notes << note
      end
    end
    notes = output_notes
    ChangeKeyJob.perform_now(Key.all.sample, scale, notes)
  end

  def away
  end
end
