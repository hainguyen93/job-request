require 'test_helper'

class AdminCanEditUserInformationTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin) 
    @staff = users(:staff)   
  end


  test "admin cannot edit user with invalid info." do
    log_in_as(@admin) 
    get edit_user_path(@staff)
    assert_template 'users/edit'    
    invalid_name = " "
    assert_not_equal @staff.name, invalid_name
    patch user_path, user: { name: invalid_name,
                             password: 'password',
                             password_confirmation: 'password' }
    assert flash.empty?
    assert_template 'users/edit' #render :new
    @staff.reload
    assert_not_equal @staff.name, invalid_name
  end


  test "admin can edit user with valid information" do
    log_in_as(@admin)
    get edit_user_path(@staff)
    valid_name = 'User Name'
    assert_not_equal @staff.name, valid_name
    patch user_path, user: { name: valid_name,
                             password: 'password',
                             password_confirmation: 'password' }
    assert_redirected_to users_path
    follow_redirect!
    assert_template 'users/index'
    assert_not flash.empty?
    @staff.reload
    assert_equal @staff.name, valid_name
  end
 
end
