class AddAttachmentPictureToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :products, :picture
  end
end
