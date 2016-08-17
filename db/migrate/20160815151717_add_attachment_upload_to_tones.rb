class AddAttachmentUploadToTones < ActiveRecord::Migration[5.0]
  def self.up
    change_table :tones do |t|
      t.attachment :upload
    end
  end

  def self.down
    remove_attachment :tones, :upload
  end
end
