class ScalesController < ApplicationController
  def index
    render locals: { scales: Scale.all }
  end

  def show
    scale = Scale.find(params[:id])
    chord1 = Chord.first
    chord2 = Chord.second
    render locals: { scale: scale, chord1: chord1, chord2: chord2 }
  end
end
