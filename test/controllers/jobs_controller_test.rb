require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  
  def setup
    @base = "Job Request System"   
    @admin = users(:admin) 
    @staff = users(:staff) 
  end

  # admin can access 'create new job' page
  test "admin gets new" do
    log_in_as(@admin)
    get :new
    assert_response :success
    assert_template 'jobs/new'
    assert_select "title", "New Job | #{@base}" 
    assert_select 'h1', text: 'Create New Job'
  end

  # staff can access 'create new job' page
  test "staff gets new" do
    log_in_as(@staff)
    get :new
    assert_response :success
    assert_template 'jobs/new'
    assert_select "title", "New Job | #{@base}" 
    assert_select 'h1', text: 'Create New Job'
  end

  # admin can see all 'active jobs'
  test "admin gets active jobs" do
    log_in_as(@admin)
    get :active_jobs
    assert_response :success
    assert_template 'jobs/active_jobs'
    assert_select "title", "Job Board | #{@base}" 
    assert_select 'h1', text: 'Job Board'
  end

  # staff can see all active jobs
  test "staff gets active jobs" do
    log_in_as(@staff)
    get :active_jobs
    assert_response :success
    assert_template 'jobs/active_jobs'
    assert_select "title", "Job Board | #{@base}" 
    assert_select 'h1', text: 'Job Board'
  end

  # admin can see all completed jobs
  test "admin gets completed jobs" do
    log_in_as(@admin)
    get :completed_jobs
    assert_response :success
    assert_template 'jobs/completed_jobs'
    assert_select "title", "Completed Jobs | #{@base}"     
  end

  # staff can see all completed jobs
  test "staff gets completed jobs" do
    log_in_as(@staff)
    get :completed_jobs
    assert_response :success
    assert_template 'jobs/completed_jobs'
    assert_select "title", "Completed Jobs | #{@base}"    
  end

  # staff can access their 'current jobs' page
  test "staff gets my jobs" do
    log_in_as(@staff)
    get :my_jobs
    assert_response :success
    assert_template 'jobs/my_jobs'
    assert_select "title", "My Jobs | #{@base}"  
    assert_select 'h1', text: 'My Current Jobs'  
  end
end
