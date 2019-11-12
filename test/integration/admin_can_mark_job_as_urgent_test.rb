require 'test_helper'

class AdminCanMarkJobAsUrgentTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
    @normal_job = jobs(:normal_job)
    @urgent_job = jobs(:urgent_job)
  end
 

  test "admin can mark normal jobs as urgent" do
    log_in_as(@admin)    
    assert_not @normal_job.urgent?    
    post urgent_path, urgent: { job_id: @normal_job.id }
    @normal_job.reload
    assert @normal_job.urgent?    
  end  

end
