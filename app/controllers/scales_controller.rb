class ScalesController < ApplicationController
  def index
    render locals: { scales: Scale.all }
  end

  def show
    scale = Scale.find(params[:id])
    # chord1 = Chord.first
    # chord2 = Chord.third
    key = Key.first
    reverb = Reverb.first
    piano_notes = []
    harp_notes = []

    notes = notes_in_key_and_scale(key.name, scale)

    scale.key_notes(key).each_with_index do |note, index|
      if notes.include?(note.name) && note.instrument.name == "piano"
        piano_notes << note
      end
      if notes.include?(note.name) && note.instrument.name == "harp"
        harp_notes << note
      end
    end
    binding.pry
    render locals: { piano_notes: piano_notes, harp_notes: harp_notes, reverb: reverb }
  end
end
