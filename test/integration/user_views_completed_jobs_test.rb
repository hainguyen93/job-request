require 'test_helper'

class UserViewsCompletedJobsTest < ActionDispatch::IntegrationTest
  
  def setup
    @staff = users(:staff)
  end

  test 'user can view all completed jobs' do
    log_in_as(@staff)
    get completed_jobs_path
    assert_template 'jobs/completed_jobs'
    #assert_select 'h1', text: 'Completed Jobs'    
  end
end
