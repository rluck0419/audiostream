class ScalesController < ApplicationController
  def index
    render locals: { scales: Scale.all }
  end

  def show
    scale = Scale.find(params[:id])
    chord = Chord.first
    render locals: { scale: scale, chord: chord }
  end
end
