class JobMailer < ApplicationMailer 

  # mail inform manager when someone starts a job
  def job_start(user, job)
    @user = user
    @job = job
    mail subject: "Job Start"
  end

  # mail inform manager when job completed
  def job_complete(job)
    @job = job
    mail subject: "Job Complete"
  end

  # mail user who current has overdue job
  def overdue_job(user, job)
    @job = job    
    mail(to: user.email, subject: 'Job Overdue')  
  end

end
