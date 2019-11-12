class ApplicationMailer < ActionMailer::Base  

  # MANAGER EMAIL
  manager_email = "t.haycock@sheffield.ac.uk"

  # PLEASE CHANGE ME !!!!!!!!!! and also in file 'config\application.yml'
  website_email = "noreply.jobrequestsystem@gmail.com"
 
  default to: manager_email 
  default from: website_email
 
  layout 'mailer'
end
