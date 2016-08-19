class NotesController < ApplicationController
  def index
    all_notes = Note.all
    notes = all_notes
    key = Key.all.sample
    piano_notes = []
    harp_notes = []
    if user_logged_in?
      scale = current_user.scales.first
      reverb = current_user.reverbs.first
      notes = notes_in_key_and_scale(key.name, scale)

      all_notes.each_with_index do |note, index|
        if notes.include?(note.name) && note.instrument.name == "piano"
          piano_notes << note
        end
        if notes.include?(note.name) && note.instrument.name == "harp"
          harp_notes << note
        end
      end
    end
    if piano_notes.empty? && harp_notes.empty?
      notes = all_notes
    else
      notes = piano_notes + harp_notes
    end
    render locals: { notes: notes, reverb: reverb }
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
