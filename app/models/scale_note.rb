class ScaleNote < ApplicationRecord
  belongs_to :note
  belongs_to :scale
  belongs_to :key
end
