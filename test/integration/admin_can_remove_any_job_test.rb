require 'test_helper'

class AdminCanRemoveAnyJobTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
    @normal_job = jobs(:normal_job)
    @urgent_job = jobs(:urgent_job)
  end
  

  test "admin can delete every job" do
    log_in_as(@admin)
    assert_difference 'Job.count', -1 do
      delete job_path(@normal_job)
    end
    assert_redirected_to active_jobs_path
    follow_redirect!
    assert_template 'jobs/active_jobs'
    assert_not flash.empty?
  end
end
