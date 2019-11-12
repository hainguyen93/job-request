require 'test_helper'

class UserCanCommentOnJobTest < ActionDispatch::IntegrationTest
   
  def setup
    @staff = users(:staff)
    @job = jobs(:job)
  end

  test "user can view job description" do
    log_in_as(@staff)
    get job_path(@job)
    assert_template 'jobs/show'
    #assert_select 'h1', text: 'Job Description'
  end

  test "admin can comment on job" do
    log_in_as(@staff)
    assert_difference 'Comment.count', 1 do
      post comments_path, comment: { user_id: @staff.id,
                                     job_id: @job.id,
                                     content: 'something' }      
    end
    assert_redirected_to job_path(@job)
    follow_redirect!
    assert_template 'jobs/show'
    # assert_select 'h1', text: 'Job Description'
  end
end
