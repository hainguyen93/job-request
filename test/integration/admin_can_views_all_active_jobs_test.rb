require 'test_helper'

class AdminCanViewsAllActiveJobsTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:admin)
    @normal_job = jobs(:normal_job)
    @urgent_job = jobs(:urgent_job)
  end


  test "admin can views all active jobs" do
    log_in_as(@admin)
    get root_path
    assert_redirected_to active_jobs_path
    follow_redirect!
    assert_template 'jobs/active_jobs'
    assert_select 'h1', text: 'Job Board'
  end
 
end



































