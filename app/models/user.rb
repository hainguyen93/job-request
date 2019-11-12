class User < ActiveRecord::Base

  attr_accessor :reset_token

  # downcase email before saving to database
  before_save { self.email = email.downcase }

  # always output user's name in alphabetical order
  default_scope -> { order(:name) }

  has_many :jobs     

  # acceptor table
  has_many :acceptors
  has_many :jobs, through: :acceptors

  # comments table
  has_many :comments  
 
  # username validation
  validates :username, presence: true, length: { maximum: 15 },
                       uniqueness: { case_sensitive: false }
  
  # name validation
  validates :name, presence: true
  
  # regular expression for email
  EMAIL_REGULAR_EXPRESSION = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # email validation
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: EMAIL_REGULAR_EXPRESSION },
                    uniqueness: { case_sensitive: false }

  # password validation
  validates :password, presence: true, 
                       length: { minimum: 6 }  
  
  has_secure_password

  # Returns the hash digest of the given string, for testing
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    self.reset_sent_at < 2.hours.ago
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

end
