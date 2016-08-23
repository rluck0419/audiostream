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
    ChangeKeyJob.perform_now(Key.all.sample, self.scales.first)
  end

  def away
  end
end
