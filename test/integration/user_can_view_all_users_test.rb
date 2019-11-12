require 'test_helper'

class UserCanViewAllUsersTest < ActionDispatch::IntegrationTest
   
  def setup   
    @staff = users(:staff)   
  end

  # user can view all users
  test "user can views all users" do
    log_in_as(@staff)
    get users_path
    assert_template 'users/index'
    assert_select 'h1', text: 'All Users'    
  end  

end
