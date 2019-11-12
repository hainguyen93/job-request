class Message < ActiveRecord::Base 
 
  # validate visitor's name
  validates :name, presence: true, length: { maximum: 100 }

  # regular expression for email
  EMAIL_REGULAR_EXPRESSION = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # email validation
  validates :email, presence: true, length: { maximum: 254 },
                    format: { with: EMAIL_REGULAR_EXPRESSION }
  
  # content validation                
  validates :content, presence: true

end
