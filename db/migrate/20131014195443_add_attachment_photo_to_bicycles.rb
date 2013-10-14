class AddAttachmentPhotoToBicycles < ActiveRecord::Migration
  def self.up
    change_table :bicycles do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :bicycles, :photo
  end
end
