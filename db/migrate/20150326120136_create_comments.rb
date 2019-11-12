class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :job, index: true
      t.text :content

      t.timestamps null: false
    end
  
  end
end
