require 'test_helper'

class UserLogOutTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
    @staff = users(:staff)
  end 
  

  # staff log-out test
  test "staff can log out from the system" do
    log_in_as(@staff)   
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'sessions/new'  
    assert_not flash.empty?
  end


  # admin log-out test
  test "admin can log out from the system" do
    log_in_as(@admin)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'sessions/new'  
    assert_not flash.empty?
  end
end
