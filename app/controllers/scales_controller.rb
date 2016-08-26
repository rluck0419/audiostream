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
    notes = MusicTheory.notes_in_key_and_scale(key.name, scale)
    chord = [notes[0], notes[2], notes[4]]
    chord6 = [notes[0], notes[2], notes[5]]
    chord64 = [notes[0], notes[3], notes[5]]
    final_notes = []

    if user_logged_in?
      favs = all_notes.map{ |n| n if current_user.instruments.include?(n.instrument) }
      rest = all_notes.map{ |n| n unless current_user.instruments.include?(n.instrument) }
      unless current_user.instruments.empty?
        instrument = current_user.instruments.first
      end
    else
      favs = all_notes.map{ |n| n if n.instrument == Instrument.first }
      rest = all_notes.map{ |n| n unless n.instrument == Instrument.first }
    end

    unless instrument
      instrument = Instrument.first
    end

    favs = favs.compact
    rest = rest.compact

    favs.each do |f|
      if notes.include?(f.name)
        final_notes << f
      end
    end

    rest.each do |r|
      if chord.include?(r.name) || chord6.include?(r.name) || chord64.include?(r.name)
        final_notes << r
      end
    end

    final_notes = final_notes.shuffle

    # insure that the first note is the root note of the scale
    popped_note = final_notes.first
    until popped_note.name == key.name && popped_note.octave == 2
      popped_note = final_notes.pop
      final_notes = [popped_note, final_notes].flatten
    end
    users = User.where.not(appearing_on: nil)

    render locals: { instrument: instrument, users: users, notes: final_notes, reverb: reverb, key: key}
    # render locals: { piano_notes: piano_notes, harp_notes: harp_notes, marimba_notes: marimba_notes, squarewave_notes: squarewave_notes, reverb: reverb }
  end
end
