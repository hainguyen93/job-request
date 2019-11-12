require 'test_helper'

class UserCreatesUrgentJobTest < ActionDispatch::IntegrationTest

  def setup
    @staff = users(:staff)
  end
 
  
  test "user creates urgent job" do
    log_in_as(@staff)  
    get new_job_path
    assert_template 'jobs/new'
    assert_select 'h1', text: 'Create New Job'
    assert_difference 'Job.count', 1 do
      post jobs_path, job: { title: 'job title',
                             'deadline(1i)': (Time.now + 1.day).year,
                             'deadline(2i)': (Time.now + 1.day).month,
                             'deadline(3i)': (Time.now + 1.day).day,
                             'deadline(4i)': 12,
                             'deadline(5i)': 12,
                             rig_id: 5,
                             description: 'something' } 
    end
    @job = Job.find_by(title: 'job title')
    assert @job.urgent?  # job marked as urgent
  end

end
