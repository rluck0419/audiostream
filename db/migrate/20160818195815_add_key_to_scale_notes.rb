class AddKeyToScaleNotes < ActiveRecord::Migration[5.0]
  def change
    add_reference :scale_notes, :key, index: true
    add_foreign_key :scale_notes, :keys
  end
end
