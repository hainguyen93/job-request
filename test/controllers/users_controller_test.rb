require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @base = "Job Request System"   
    @admin = users(:admin) 
    @staff = users(:staff) 
  end

  test "admin gets new" do
    log_in_as(@admin)
    get :new
    assert_response :success
    assert_template 'users/new'
    assert_select "title", "New User | #{@base}" 
    assert_select 'h1', text: 'Create New User'
  end

  test "admin gets index" do
    log_in_as(@admin)
    get :index
    assert_response :success
    assert_template 'users/index'
    assert_select "title", "All Users | #{@base}" 
    assert_select 'h1', text: 'All Users'
  end

    test "staff gets index" do
    log_in_as(@staff)
    get :index
    assert_response :success
    assert_template 'users/index'
    assert_select "title", "All Users | #{@base}" 
    assert_select 'h1', text: 'All Users'
  end
end
