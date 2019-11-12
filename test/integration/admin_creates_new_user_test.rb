require 'test_helper'

class AdminCreatesNewUserTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:admin)
  end

  # create new user with invalid information
  test "admin creates new user with invalid info" do
    log_in_as(@admin)
    # create new user
    get new_user_path
    assert_template 'users/new'
    assert_select 'h1', text: 'Create New User'
    assert_no_difference 'User.count' do
      post users_path, user: { username: ' ',
                               email: 'abc.gmail.com',
                               name: 'username',
                               password: 'password',
                               password_confirmation: 'password' }
    end
    assert_template 'users/new'  # render :new
    assert flash.empty?
  end

  #create user with valid information
  test "admin creates new user with valid info" do
    log_in_as(@admin)
    # create new user
    get new_user_path
    assert_template 'users/new'
    assert_select 'h1', text: 'Create New User'
    assert_difference 'User.count', 1 do
      post users_path, user: { username: 'username',
                               email: 'abc@gmail.com',
                               name: 'username',
                               password: 'password',
                               password_confirmation: 'password' }
    end
    assert_redirected_to users_path
    follow_redirect!
    assert_template 'users/new'  
    assert_not flash.empty?
  end
end
