class SessionsController < ApplicationController

  before_action :logged_in_user, only: :destroy

  # log-in page
  def new    
    if logged_in?       
      redirect_to active_jobs_path 
    end  
  end

  # log-in user by creating a session[:user_id]
  def create
    user = User.find_by(username: params[:session][:username])
    if (user && (!user.disabled? && user.authenticate(params[:session][:password])))      
      log_in user       
      redirect_back_or active_jobs_path   
    else   
      flash.now[:danger] = "Invalid Username/Password Combination" 
      render :new
    end
  end

  # log-out user by destroy session[:user_id]
  def destroy
    log_out if logged_in?
    flash[:success] = 'Logged out successfully'
    redirect_to root_path
  end  
  
end
