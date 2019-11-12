class CreateAcceptors < ActiveRecord::Migration
  def change
    create_table :acceptors do |t|
      t.references :user, index: true
      t.references :job, index: true

      t.timestamps null: false
    end
 
  end
end
