class AddAttachmentToSupportDocuments < ActiveRecord::Migration
  def change
    add_attachment :support_documents, :document
  end
end
