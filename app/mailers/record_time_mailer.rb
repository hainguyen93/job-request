class RecordTimeMailer < ApplicationMailer 
  
  def record_time_email(user, job)
    @job = job
    mail(to: user.email, subject: 'Enter time spent on job')    
  end
end
