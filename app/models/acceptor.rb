class Acceptor < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  validates :user_id, presence: true

  validates :job_id, presence: true

  # validate unique pair of user and job
  validates_uniqueness_of :user_id, scope: :job_id
 
end
