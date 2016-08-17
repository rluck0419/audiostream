class AddOctaveColumnToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :octave, :smallint
  end
end
