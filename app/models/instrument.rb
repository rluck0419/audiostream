class Instrument < ApplicationRecord
  has_many :notes
  has_many :user_instruments
end
