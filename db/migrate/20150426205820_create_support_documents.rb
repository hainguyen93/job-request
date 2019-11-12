class CreateSupportDocuments < ActiveRecord::Migration
  def change
    create_table :support_documents do |t|
      t.references :jobs, index: true

      t.timestamps
    end
  end
end
