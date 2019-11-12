require 'test_helper'

class AdminCanRemoveRigTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin) 
    @rig = rigs(:rig1)     
  end
  

  # admin can delete rig code
  test "admin can delete rig code" do
    log_in_as(@admin)
    @rig.save
    assert_difference 'Rig.count', -1 do
      delete rig_path(@rig)
    end
    assert_redirected_to rigs_path
    follow_redirect!    
    assert_template 'rigs/index'
    assert_not flash.empty?
  end
end
