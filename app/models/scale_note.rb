class ScaleNote < ApplicationRecord
  belongs_to :note
  belongs_to :scale
end
