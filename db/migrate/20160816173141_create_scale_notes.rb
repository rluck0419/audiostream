class CreateScaleNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :scale_notes do |t|
      t.belongs_to :note, foreign_key: true
      t.belongs_to :scale, foreign_key: true

      t.timestamps
    end
  end
end
