class ScalesController < ApplicationController
  def index
    render locals: { scales: Scale.all }
  end

  def show
    scale = Scale.find(params[:id])
    # chord1 = Chord.first
    # chord2 = Chord.third
    key = Key.all.sample
    reverb = Reverb.first
    # piano_notes = []
    # harp_notes = []
    # marimba_notes = []
    # squarewave_notes = []
    all_notes = Note.all
    notes = notes_in_key_and_scale(key.name, scale)
    final_notes = []

    all_notes.each_with_index do |note, index|
      if notes.include?(note.name) && note.instrument.name == "piano"
        final_notes << note
        # piano_notes << note
      end
      if notes.include?(note.name) && note.instrument.name == "harp"
        final_notes << note
        # harp_notes << note
      end
      if notes.include?(note.name) && note.instrument.name == "marimba"
        final_notes << note
        # marimba_notes << note
      end
      if notes.include?(note.name) && note.instrument.name == "squarewave"
        final_notes << note
        # squarewave_notes << note
      end
    end
    final_notes = final_notes.shuffle

    popped_note = final_notes.first
    until popped_note.name == key.name && popped_note.octave == 2
      popped_note = final_notes.pop
      final_notes = [popped_note, final_notes].flatten
    end

    render locals: { notes: final_notes, reverb: reverb, key: key.name}
    # render locals: { piano_notes: piano_notes, harp_notes: harp_notes, marimba_notes: marimba_notes, squarewave_notes: squarewave_notes, reverb: reverb }
  end
end
