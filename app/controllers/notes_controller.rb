class NotesController < ApplicationController
  def index
    all_notes = Note.all
    notes = all_notes
    key = Key.all.sample
    output_notes = []
    users = User.where.not(appearing_on: nil)
    if user_logged_in?
      if current_user.scales.empty?
        scale = Scale.first
      else
        scale = current_user.scales.first
      end

      if current_user.reverbs.empty?
        reverb = Reverb.first
      else
        reverb = current_user.reverbs.first
      end

      notes = notes_in_key_and_scale(key.name, scale)

      if current_user.instruments.empty?
        instrument = Instrument.first
      else
        instrument = current_user.instruments.first
      end

      all_notes.each_with_index do |note, index|
        if notes.include?(note.name) && note.instrument.name == instrument.name
          output_notes << note
        end
      end
    end
    render locals: { notes: output_notes, reverb: reverb, users: users }
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
