class AddUploadColumnToComments < ActiveRecord::Migration
  def self.up
    add_attachment :comments, :upload
  end

  def self.down
    remove_attachment :comments, :upload
  end
end
