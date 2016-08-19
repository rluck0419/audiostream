class UserChord < ApplicationRecord
  belongs_to :user
  belongs_to :chord
end
