require 'test_helper'

class AdminCanCreateJobTest < ActionDispatch::IntegrationTest
 
  def setup
    @admin = users(:admin)
  end


  test "admin creates new job with valid info" do
    log_in_as(@admin)  
    get new_job_path
    assert_template 'jobs/new'
    assert_select 'h1', text: 'Create New Job'
    assert_difference 'Job.count', 1 do
      post jobs_path, job: { title: 'job title',
                             'deadline(1i)': 2015,
                             'deadline(2i)': 6,
                             'deadline(3i)': 1,
                             'deadline(4i)': 12,
                             'deadline(5i)': 0,
                             rig_id: 5,
                             description: 'something' } 
    end
    @job = Job.find_by(title: 'job title')
    assert_redirected_to job_path(@job)
    follow_redirect!
    assert_template 'jobs/new'
    assert_not flash.empty?    
  end


  test "admin cannot create new job with invalid info" do
    log_in_as(@admin) 
    get new_job_path
    assert_template 'jobs/new'
    assert_select 'h1', text: 'Create New Job'
    assert_no_difference 'Job.count'  do
      post jobs_path, job: { title: ' ',
                             'deadline(1i)': 2015,
                             'deadline(2i)': 6,
                             'deadline(3i)': 1,
                             'deadline(4i)': 12,
                             'deadline(5i)': 0,
                             rig_id: nil,
                             description: 'something' } 
    end    
    assert_template 'jobs/new'  # render :new
    assert flash.empty?    
  end

end
