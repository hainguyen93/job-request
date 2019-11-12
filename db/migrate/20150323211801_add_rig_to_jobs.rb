class AddRigToJobs < ActiveRecord::Migration
  def change
    add_reference :jobs, :rig, index: true

  end
end
