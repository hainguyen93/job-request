class AddAttachmentToCommentFiles < ActiveRecord::Migration
  def change
    add_attachment :comment_files, :upload
  end
end
