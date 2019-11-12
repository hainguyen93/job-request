require 'test_helper'

class AdminViewsCompletedJobsTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:admin)
  end

  test 'admin can view all completed jobs' do
    log_in_as(@admin)
    get completed_jobs_path
    assert_template 'jobs/completed_jobs'
    #assert_select 'h1', text: 'Completed Jobs'    
  end
  
end
