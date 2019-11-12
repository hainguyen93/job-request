require 'test_helper'

class AdminCanRemoveUserTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin) 
    @staff = users(:staff)   
  end
  

  # admin can delete user
  test "admin can delete user" do
    log_in_as(@admin)
    @staff.save
    assert_not @staff.disabled?   
    post disable_path, disable_user: { user_id: @staff.id } 
    @staff.reload  
    assert @staff.disabled?   
    assert_redirected_to users_path
    follow_redirect!
    assert_not flash.empty? 
    assert_template 'users/index'    
  end
end
