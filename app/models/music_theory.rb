class MusicTheory < ApplicationRecord
  NOTES = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
  CIRCLE_OF_FIFTHS = ['C', 'G', 'D', 'A', 'E', 'F#', 'C#', 'G#', 'D#', 'A#', 'F']

  def self.notes_in_key_and_scale(key, scale)
    key = NOTES.index(key)

    scale = scale.degrees.map{ |deg| (deg + key) % 12 }
    notes = scale.map{ |note| NOTES[note] }
    notes
  end

  def self.next_key(key)
    if key == CIRCLE_OF_FIFTHS.last
      next_key = CIRCLE_OF_FIFTHS.first
    else
      next_key = CIRCLE_OF_FIFTHS[CIRCLE_OF_FIFTHS.index(key) + 1]
    end
    binding.pry
    next_key
  end
end
