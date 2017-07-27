class AddAttachmentPhotoToManuals < ActiveRecord::Migration[5.1]
  def self.up
    change_table :manuals do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :manuals, :photo
  end
end
