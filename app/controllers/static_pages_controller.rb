class StaticPagesController < ApplicationController

  # about page
  def about
  end

  # contact page
  def contact 
    @message = Message.new   
  end 

  # process contact form submission
  def create
    @message = Message.new(message_params)
    if @message.valid?
      MessageMailer.contact_message(@message).deliver
      flash[:success] = "Your message has been sent successfully"
      redirect_to contact_path
    else     
      render :contact
    end
  end
  
  private 
    
    # strong parameter
    def message_params
      params.require(:message).permit(:name, :email, :content)
    end

end
