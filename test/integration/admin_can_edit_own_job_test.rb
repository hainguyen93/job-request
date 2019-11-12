require 'test_helper'

class AdminCanEditOwnJobTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
    @normal_job = jobs(:normal_job)
    @urgent_job = jobs(:urgent_job)
  end
 

  test "admin cannot edit own jobs with invalid information" do
    log_in_as(@admin)
    assert_equal @admin.id, @normal_job.user_id
    get edit_job_path(@normal_job)
    invalid_title = ' '
    @rig = rigs(:rig2)
    assert_not_equal @normal_job.title, invalid_title
    patch job_path(@normal_job), job: { title: invalid_title,
                                        rig_id: @rig.id,
                                        'deadline(1i)': 2015,
                                        'deadline(2i)': 6,
                                        'deadline(3i)': 1,
                                        'deadline(4i)': 12,
                                        'deadline(5i)': 0,
                                        description: 'something',
                                        user_id: @admin.id }
    @normal_job.reload
    assert_not_equal @normal_job.title, invalid_title
    assert_template 'jobs/edit'    
  end

  
  test "admin can edit own jobs with valid information" do
    log_in_as(@admin)  
    assert_equal @admin.id, @normal_job.user_id
    get edit_job_path(@normal_job)
    @rig = rigs(:rig2)
    valid_title = 'valid title'
    assert_not_equal @normal_job.title, valid_title
    patch job_path(@normal_job), job: { title: valid_title, 
                                        rig_id: @rig.id,
                                        'deadline(1i)': 2015,
                                        'deadline(2i)': 6,
                                        'deadline(3i)': 1,
                                        'deadline(4i)': 12,
                                        'deadline(5i)': 0,
                                        description: 'something',
                                        user_id: @admin.id }
    @normal_job.reload
    assert_equal valid_title, @normal_job.title    
    assert_redirected_to job_path(@normal_job)
    follow_redirect!
    assert_template 'jobs/show' 
    assert_not flash.empty?
  end
  
end
