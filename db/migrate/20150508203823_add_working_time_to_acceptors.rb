class AddWorkingTimeToAcceptors < ActiveRecord::Migration
  def change
    add_column :acceptors, :working_time, :float
  end
end
