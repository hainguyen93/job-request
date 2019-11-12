desc 'send overdue mail'
task send_overdue_mail: :environment do
  Job.overdue_mail_alert
end
