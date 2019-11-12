class AcceptorsController < ApplicationController

  before_action :logged_in_user  

  def create
    @acceptor = Acceptor.new(user_id: current_user.id, job_id: params[:acceptor][:job_id])
    if @acceptor.save  
      @job = Job.find_by(id: params[:acceptor][:job_id])      
      JobMailer.job_start(current_user, @job).deliver  # send email to manager
      redirect_to my_jobs_url
    else
      render 'sessions/new'
    end
  end

  # adding working time to system.
  def record_time
    @acceptor = Acceptor.find_by(job_id: params[:time][:job_id], user_id: current_user.id)
    if (@acceptor.update_attribute(:working_time, params[:time][:working_time]))
      flash[:success] = "Time has been recorded successfully"   
    end
    current_job = Job.find_by(id: params[:time][:job_id])
    redirect_to job_path(current_job)      
  end

end
