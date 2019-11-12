require 'test_helper'

class UserCanEditOwnJobTest < ActionDispatch::IntegrationTest

  def setup
    @staff = users(:staff)
    @job = jobs(:job)    
  end


  test "user cannot edit own jobs with invalid information" do
    log_in_as(@staff)
    assert_equal @staff.id, @job.user_id
    get edit_job_path(@job)
    invalid_title = ' '
    @rig = rigs(:rig2)
    assert_not_equal @job.title, invalid_title
    patch job_path(@job), job: { title: invalid_title,
                                        rig_id: @rig.id,
                                        'deadline(1i)': 2015,
                                        'deadline(2i)': 6,
                                        'deadline(3i)': 1,
                                        'deadline(4i)': 12,
                                        'deadline(5i)': 0,
                                        description: 'something',
                                        user_id: @staff.id }
    @job.reload
    assert_not_equal @job.title, invalid_title
    assert_template 'jobs/edit'    
  end
  

  test "user can edit own jobs with valid information" do
    log_in_as(@staff)
    assert_equal @staff.id, @job.user_id  
    get edit_job_path(@job)
    @rig = rigs(:rig2)
    valid_title = 'valid title'
    assert_not_equal @job.title, valid_title
    patch job_path(@job), job: { title: valid_title, 
                                        rig_id: @rig.id,
                                        'deadline(1i)': 2015,
                                        'deadline(2i)': 6,
                                        'deadline(3i)': 1,
                                        'deadline(4i)': 12,
                                        'deadline(5i)': 0,
                                        description: 'something',
                                        user_id: @staff.id }
    @job.reload
    assert_equal valid_title, @job.title    
    assert_redirected_to job_path(@job)
    follow_redirect!
    assert_template 'jobs/show' 
    assert_not flash.empty?
  end

end
