class NotesController < ApplicationController

  def index
    if user_logged_in?
      unless current_user.instruments.empty?
        instrument = current_user.instruments.first
      end
      unless current_user.scales.empty?
        $_scale = current_user.scales.first if $_scale.nil?
      end
      unless current_user.reverbs.empty?
        reverb = current_user.reverbs.first
      end
    end

    unless instrument
      instrument = Instrument.first
    end
    unless $_scale
      $_scale = Scale.first
    end
    unless reverb
      reverb = Reverb.first
    end

    all_notes = Note.where(instrument: instrument)
    notes = all_notes
    $_key = Key.all.sample if $_key.nil?
    output_notes = []

    users = CurrentUser.all.map(&:user)

    notes = MusicTheory.notes_in_key_and_scale($_key.name, $_scale)

    all_notes.each_with_index do |note, index|
      if notes.include?(note.name)
        output_notes << note
      end
    end
    render locals: { instrument: instrument, notes: output_notes, reverb: reverb, users: users, key: $_key }
  end

  def new
    render locals: { note: Note.new }
  end

  def create
    note = Note.new(note_params)
    if note.save
      redirect_to notes_path
    else
      flash[:alert] = "Note could not be created: #{note.errors.full_messages}"
      render :new, locals: { note: note }
    end
  end

  def destroy
    note = Note.find(params[:id])
    if note
      note.destroy
      flash[:notice] = "Note deleted"
      redirect_to notes
    else
      flash[:alert] = note.errors
    end
  end

  private

  def note_params
    params.require(:note).permit(:name, :upload)
  end
end
