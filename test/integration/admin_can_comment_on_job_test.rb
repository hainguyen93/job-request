require 'test_helper'

class AdminCanCommentOnJobTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:admin)
    @job = jobs(:normal_job)
    @cmt1 = comments(:admin_cmt)  # admin's comment
    @cmt2 = comments(:staff_cmt)  # staff's comment
  end


  test "admin can view job description" do
    log_in_as(@admin)
    get job_path(@job)
    assert_template 'jobs/show'
    #assert_select 'h1', text: 'Job Description'
  end


  test "admin can comment on job" do
    log_in_as(@admin)
    assert_difference 'Comment.count', 1 do
      post comments_path, comment: { user_id: @admin.id,
                                     job_id: @job.id,
                                     content: 'something' }      
    end
    assert_redirected_to job_path(@job)
    follow_redirect!
    assert_template 'jobs/show'    
  end
 
end
