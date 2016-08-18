class ScalesController < ApplicationController
  def index
    render locals: { scales: Scale.all }
  end

  def show
    scale = Scale.find(params[:id])
    chord1 = Chord.first
    chord2 = Chord.second
    key = Key.first
    piano_notes = []
    harp_notes = []

    scale.key_notes(key).each_with_index do |note, index|
      if chord1.intervals.include?(index % scale.degrees.length) && note.instrument.name == "piano"
        piano_notes << note
      end
      if chord2.intervals.include?(index % scale.degrees.length) && note.instrument.name == "harp"
        harp_notes << note
      end
    end
    render locals: { piano_notes: piano_notes, harp_notes: harp_notes }
  end
end
