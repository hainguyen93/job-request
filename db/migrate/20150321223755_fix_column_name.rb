class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :disable,  :disabled
  end
end
