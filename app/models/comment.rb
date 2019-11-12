class Comment < ActiveRecord::Base
  include Bootsy::Container

  belongs_to :user
  belongs_to :job

  has_many :comment_files, dependent: :destroy
 
  # validates :content, presence: true

  validates :user_id, presence: true

  validates :job_id, presence: true
  
end
