require 'test_helper'

class AdminViewsAllUsersTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:admin) 
    @staff = users(:staff)   
  end


  # admin can view all users
  test "admin can views all users" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'h1', text: 'All Users'    
  end
  
end
