require 'test_helper'

class AdminCanEditRigTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin) 
    @rig = rigs(:rig1)     
  end


  test "admin can edit rig code with valid information" do
    log_in_as(@admin)
    get edit_rig_path(@rig)
    valid_code = '123 valid code'
    patch rig_path, rig: { code: valid_code }
    assert_redirected_to rigs_path
    follow_redirect!
    assert_template 'rigs/index'
    assert_not flash.empty?
    @rig.reload
    assert_equal @rig.code, valid_code
  end


  test "admin cannot edit rig with invalid information" do
    log_in_as(@admin)
    get edit_rig_path(@rig)
    invalid_code = ''          # invalid rig code
    patch rig_path, rig: { code: invalid_code }   
    assert_template 'rigs/edit'
    assert flash.empty?   
  end
 
end
