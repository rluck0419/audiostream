class ScalesController < ApplicationController
  def index
    render locals: { scales: Scale.all }
  end

  def show

    render locals: { scale: Scale.find(params[:id]) }
  end
end
