class DeleteAttachmentToComments < ActiveRecord::Migration
  def change
    remove_attachment :comments, :upload
  end
end
