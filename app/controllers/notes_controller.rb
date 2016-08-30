class NotesController < ApplicationController

  def index
    if user_logged_in?
      instrument = current_user.get_instrument
      $_scale ||= current_user.get_scale
      reverb = current_user.get_reverb
    end

    instrument ||= Instrument.first
    reverb     ||= Reverb.first
    $_scale    ||= Scale.first
    $_key      ||= Key.all.sample

    all_notes = Note.where(instrument: instrument)
    users = CurrentUser.all.map(&:user)
    notes = MusicTheory.notes_in_key_and_scale($_key.name, $_scale)

    output_notes = all_notes.map do |note|
      note if notes.include?(note.name)
    end.compact

    if current_user
      @user = current_user
    else
      @user = User.new
    end

    render locals: {
      instrument: instrument,
      notes: output_notes,
      reverb: reverb,
      users: users,
      key: $_key
    }
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
