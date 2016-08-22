class User < ApplicationRecord
  require 'current_user'
  include CurrentUser
  has_secure_password
  has_many :user_instruments
  has_many :instruments, through: :user_instruments

  has_many :user_chords
  has_many :chords, through: :user_chords

  has_many :user_scales
  has_many :scales, through: :user_scales

  has_many :user_reverbs
  has_many :reverbs, through: :user_reverbs

  def appear(datetime = Time.zone.now)
    self.appearing_on = datetime
    self.save
  end

  def dissappear
  end

  def away
  end
end
