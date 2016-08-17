class Scale < ApplicationRecord
  has_many :scale_notes
  has_many :notes, through: :scale_notes
end
