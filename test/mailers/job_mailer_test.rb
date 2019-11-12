require 'test_helper'

class JobMailerTest < ActionMailer::TestCase
  
  def setup
    @job = Job.create(title: "new job", 
                   rig_id: 10,
                   description: "a short description", 
                   deadline: '2015-06-20 12:00:00')

    @user = User.create(username: "username", name: "user", email: "user@gmail.com",
                     password: "mypassowrd", password_confirmation: "mypassword")    
  end
  
  # test manager receive email when staff starts doing job
  test "job start email" do
    mail = JobMailer.job_start(@user, @job)
    assert_equal "Job Start", mail.subject
    # assert_equal ["t.haycock@sheffield.ac.uk"], mail.to
    assert_equal ["noreply.jobrequestsystem@gmail.com"], mail.from
    assert_match @user.name, mail.body.encoded
    assert_match @job.title, mail.body.encoded      
  end

  # test manager receives mail when staff close job
  test "job complete email" do
    mail = JobMailer.job_complete(@job)
    assert_equal "Job Complete", mail.subject
    # assert_equal ["t.haycock@sheffield.ac.uk"], mail.to
    assert_equal ["noreply.jobrequestsystem@gmail.com"], mail.from   
    assert_match @job.title, mail.body.encoded      
  end

end
