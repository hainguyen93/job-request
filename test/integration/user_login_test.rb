require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
    @staff = users(:staff)
  end
  

  test "login with invalid information" do
    get root_path
    assert_template 'sessions/new'
    post login_path, session: { username: " ",
                                password: " " }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path     # refresh home page
    assert flash.empty?
  end
  

  # staff login test
  test "staff login with valid information" do
    #login
    get root_path
    assert_template 'sessions/new'
    post login_path, session: { username: @staff.username,
                                password: 'hai5193' }
    assert_redirected_to active_jobs_path
    follow_redirect!
    assert_template 'jobs/active_jobs'
    assert is_logged_in?
    assert_select 'h1', text: 'Job Board'    
  end


  # admin login test
  test "admin login with valid information" do
    #login
    get root_path
    assert_template 'sessions/new'
    post login_path, session: { username: @admin.username,
                                password: 'hai5193' }
    assert_redirected_to active_jobs_path
    follow_redirect!
    assert_template 'jobs/active_jobs'
    assert is_logged_in?
    assert_select 'h1', text: 'Job Board'    
  end
end
