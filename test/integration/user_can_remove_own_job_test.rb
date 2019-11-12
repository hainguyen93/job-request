require 'test_helper'

class UserCanRemoveOwnJobTest < ActionDispatch::IntegrationTest

  def setup
    @staff = users(:staff)
    @job = jobs(:job)  # job created by staff
  end
  

  test "user can delete every job" do
    log_in_as(@staff)
    assert_difference 'Job.count', -1 do
      delete job_path(@job)
    end
    assert_redirected_to active_jobs_path
    follow_redirect!
    assert_template 'jobs/active_jobs'
    assert_not flash.empty?
  end
end
