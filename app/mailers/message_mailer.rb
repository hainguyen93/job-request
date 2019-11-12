class MessageMailer < ApplicationMailer   

  def contact_message(message)
    @message = message
    mail subject: "Visitor Message"
  end

end
