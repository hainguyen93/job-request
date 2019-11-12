require 'test_helper'

class AdminCreatesNewRigTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:admin)
  end

  # create new rig with invalid information
  test "admin creates new rig with invalid info" do
    log_in_as(@admin)
    # create new rig
    get new_rig_path
    assert_template 'rigs/new'
    assert_select 'h1', text: 'Register New RIG'
    assert_no_difference 'Rig.count' do
      post rigs_path, rig: { code: ' ' }
    end
    assert_template 'rigs/new'  # render :new
    assert flash.empty?
  end


  #create rig with valid information
  test "admin creates new rig with valid info" do
    log_in_as(@admin)
    # create new rig
    get new_rig_path
    assert_template 'rigs/new'
    assert_select 'h1', text: 'Register New RIG'
    assert_difference 'Rig.count', 1 do
      post rigs_path, rig: { code: '111 abc' }
    end
    assert_redirected_to rigs_path
    follow_redirect!
    assert_template 'rigs/new' 
    assert_not flash.empty?
  end
end
