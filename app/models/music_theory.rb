class MusicTheory < ApplicationRecord
  NOTES = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']

  def self.notes_in_key_and_scale(key, scale)
    key = NOTES.index(key)

    scale = scale.degrees.map{ |deg| (deg + key) % 12 }
    notes = scale.map{ |note| NOTES[note] }
    notes
  end
end
