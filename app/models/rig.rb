class Rig < ActiveRecord::Base
  has_many :jobs
  
  # before_save { self.code = code.downcase }

  # always output rig codes in alphabetical order
  default_scope -> { order(:code) }

  # RIG_REGEX = /\A\d+\s+(\w\s*)+\z/i 

  validates :code, presence: true, uniqueness: { case_sensitive: false }
                  # format: { with: RIG_REGEX }

end
