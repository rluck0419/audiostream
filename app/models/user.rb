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
    CurrentUser.find_or_create_by(user: self)

    self.appearing_on = datetime[:on] || Time.zone.now
    self.save
    $_key = Key.all.sample if $_key.nil?
    $_scale = self.scales.sample if $_scale.nil?

    output_notes = set_notes($_key, $_scale)

    UserAppearJob.perform_now(self, self.appearing_on, output_notes)
  end

  def disappear
    self.appearing_on = nil
    self.save

    CurrentUser.where(user_id: self.id).destroy_all
    UserDisappearJob.perform_now(self)
  end

  def key_change
    next_key = MusicTheory.next_key($_key.name)
    $_key = Key.find_by(name: next_key)
    $_scale = self.scales.sample

    output_notes = set_notes($_key, $_scale)

    ChangeKeyJob.perform_now(self, $_key, $_scale, output_notes)
  end

  def as_json(_ = nil)
    super(include: :instruments, except: :password_digest)
  end

  def get_instrument
    instruments.first || Instrument.first
  end

  def get_scale
    scales.first || Scale.first
  end

  def get_reverb
    reverbs.first || Reverb.first
  end

  def set_notes(key, scale)
    users = CurrentUser.includes(user: :instruments).where.not(user_id: nil)
    instruments = users.map{ |u| u.user }.flat_map(&:instruments)

    notes = MusicTheory.notes_in_key_and_scale(key.name, scale)

    all_notes = Note.where(instrument: instruments.uniq)

    output_notes = all_notes.map do |note|
      note if notes.include?(note.name)
    end.compact
    output_notes
  end
end
