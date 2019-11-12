class CreateRigs < ActiveRecord::Migration
  def change
    create_table :rigs do |t|
      t.string :code

      t.timestamps null: false
    end
  end
end
