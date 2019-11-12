class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :chargeCode
      t.string :title
      t.datetime :deadline
      t.references :user, index: true
      t.text :description
      t.boolean :urgent
      t.string :status

      t.timestamps null: false
    end    
    add_index :jobs, [:deadline]
  end
end
