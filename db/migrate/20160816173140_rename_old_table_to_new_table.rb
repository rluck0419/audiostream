class RenameOldTableToNewTable < ActiveRecord::Migration[5.0]
  def self.up
    rename_table :tones, :notes
  end
  def self.down
    rename_table :notes, :tones
  end
end
