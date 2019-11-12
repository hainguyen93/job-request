require 'test_helper'

class UserCanViewAllActiveJobsTest < ActionDispatch::IntegrationTest
   
  def setup
    @staff = users(:staff)
    @job = jobs(:job)    
  end


  test "user can views all active jobs" do
    log_in_as(@staff)
    get active_jobs_path      
    assert_template 'jobs/active_jobs'
    assert_select 'h1', text: 'Job Board'
  end 
 
end
