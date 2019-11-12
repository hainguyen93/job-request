class DeleteAttachmentToJobs < ActiveRecord::Migration
  def change
    remove_attachment :jobs, :document
  end
end
