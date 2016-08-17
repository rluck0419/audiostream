class AddInstrumentToNote < ActiveRecord::Migration[5.0]
  def change
    add_reference :notes, :instrument, foreign_key: true
  end
end
