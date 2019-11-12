class AddDocumentColumnToJobs < ActiveRecord::Migration
  def self.up
    add_attachment :jobs, :document
  end

  def self.down
    remove_attachment :jobs, :document
  end
end
