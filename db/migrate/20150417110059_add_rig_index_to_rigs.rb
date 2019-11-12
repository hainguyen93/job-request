class AddRigIndexToRigs < ActiveRecord::Migration
  def change
    add_index :rigs, :code, unique: true
  end
end
