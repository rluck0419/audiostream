class AddAttachmentUploadToReverbs < ActiveRecord::Migration[5.0]
  def self.up
    change_table :reverbs do |t|
      t.attachment :upload
    end
  end

  def self.down
    remove_attachment :reverbs, :upload
  end
end
