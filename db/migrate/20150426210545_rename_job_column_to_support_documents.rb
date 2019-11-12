class RenameJobColumnToSupportDocuments < ActiveRecord::Migration
  def change
    rename_column :support_documents, :jobs_id, :job_id
  end
end
