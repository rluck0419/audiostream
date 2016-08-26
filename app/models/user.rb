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
    CurrentUser.create!(user: self)

    self.appearing_on = datetime[:on] || Time.zone.now
    self.save
    $_key = Key.all.sample if $_key.nil?
    $_scale = self.scales.sample if $_scale.nil?



    users = CurrentUser.all
    instruments = users.map(&:user).flat_map(&:instruments)

    notes = MusicTheory.notes_in_key_and_scale($_key.name, $_scale)

    all_notes = Note.where(instrument: instruments)
    output_notes = []

    output_notes = all_notes.map do |note|
      note if notes.include?(note.name)
    end.compact

    UserAppearJob.perform_now(self, self.appearing_on, output_notes)
  end

  def disappear
    self.appearing_on = nil
    self.save

    CurrentUser.find_by(user: self).try(:destroy)
    UserDisappearJob.perform_now(self)
  end

  def key_change
    $_key = Key.all.sample
    $_scale = self.scales.sample
    notes = MusicTheory.notes_in_key_and_scale($_key.name, $_scale)
    current_instruments = $_current_users.map { |user| user.instruments.sample }

    all_notes = Note.where(instrument: current_instruments)
    output_notes = []

    all_notes.each do |note|
      if notes.include?(note.name)
        output_notes << note
      end
    end
    notes = output_notes
    ChangeKeyJob.perform_now(self, $_key, $_scale, notes)
  end

  def away
  end
end
