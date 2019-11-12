class Job < ActiveRecord::Base
  include Bootsy::Container
  
  # originator
  belongs_to :user

  # rig code
  belongs_to :rig 

  # acceptance relationship
  has_many :acceptors
  has_many :users, through: :acceptors

  # contain many supporting documents
  has_many :support_documents, dependent: :destroy

  # comments table, if job deleted, all related comments get deleted too.
  has_many :comments, dependent: :destroy

  validates :title, presence: true   

  validates :description, presence: true  

  validates :rig_id, presence: true  
 
  # validate deadline, using validate_timeliness gem
  # job length must be at least 30 minutes
  validates_datetime :deadline, after: lambda { Time.now + 30.minutes },
                                after_message: "must be in the future" 


  # job with length <3 days moves to urgent job
  def Job.filter
    @job = Job.where(urgent: false, status: 'ongoing')
    @job.each do |job| 
      if job.deadline.utc < (Time.now + 3.days).utc
        job.update_attribute(:urgent, true)  
      end
    end
  end   

  # alert people via email if they have overdue job
  def Job.overdue_mail_alert
    jobs = Job.where(status: 'ongoing')   # all active jobs
    jobs.each do |job|
      if (job.deadline.utc < Time.now.utc)    # overdue job
        acc = Acceptor.where(job_id: job.id)   # all users currently doing this job
        acc.each do |acc|
          JobMailer.overdue_job(acc.user, job).deliver
        end
      end
    end    
  end
 
end
