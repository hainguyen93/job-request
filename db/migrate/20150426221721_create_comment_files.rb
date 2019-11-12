class CreateCommentFiles < ActiveRecord::Migration
  def change
    create_table :comment_files do |t|
      t.references :comment, index: true

      t.timestamps
    end
  end
end
