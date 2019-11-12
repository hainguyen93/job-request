class JobsController < ApplicationController
  
  before_action :logged_in_user
  before_action :get_job, only: [:edit, :update, :destroy, :show]
  before_action :correct_user_to_edit, only: [:edit, :update]
  before_action :correct_user_to_delete, only: :destroy 
  before_action :admin_user, only: [:mark_as_urgent, :reactivate_job]
  before_action :staff_user, only: [:my_jobs, :close_job] 
  
  # create new job
  def new    
    @job = Job.new   
  end

  # create action to create new job
  def create      
    @job = Job.new(job_params)      
    if @job.save     
      if params[:files]
        params[:files].each do |file|    # upload multiple files
          @job.support_documents.create(document: file)   
        end
      end 
      flash[:success]="Job has been successfully created"
      redirect_to job_path(@job)   # redirect to job show-path
    else        
      render :new
    end      
  end  
 
  # show a job description
  def show
    @comment = Comment.new
    @comments = Comment.where(job_id: @job.id)    
  end

  # edit normal job page
  def edit 
  end

  # update action to update job
  def update
    if @job.update_attributes(job_params) 
      if params[:files]
        @job.support_documents.destroy_all  #destroy all old files
        params[:files].each do |file|
          @job.support_documents.create(document: file)  
        end
      end  
      flash[:success] = "Job description updated successfully"
      redirect_to job_path(@job)
    else
      render :edit    # fail to update
    end
  end

  # action to delete jobs
  def destroy
    @job.destroy  # all support documents automatically get destroyed
    flash[:success] = "Job has been successfully deleted"
    redirect_to active_jobs_path
  end

  # my current jobs
  def my_jobs
    @urgents = Job.where(urgent: true, status: 'ongoing',).order(:deadline)  
    @currents = Job.where(urgent: false, status: 'ongoing').order(:deadline)   
  end

  # active jobs, homepage
  def active_jobs                
    @urgents = Job.where(urgent: true, status: 'ongoing').order(:deadline).paginate(page: params[:urgents_page], per_page: 15)
    @currents = Job.where(urgent: false, status: 'ongoing').order(:deadline).paginate(page: params[:currents_page], per_page: 15)     
    @acceptor = Acceptor.new   
    @warning = true
  end

  # show all completed jobs
  def completed_jobs
     @completed_jobs = Job.where(status: 'done').order(:deadline).paginate(page: params[:page], per_page: 15)
  end

  # close completed jobs
  def close_job
    @job = Job.find_by(id: params[:done][:job_id])
    @job.update_attribute(:status, 'done')  
    check_time_recorded     # send email remind user records time spent 
    JobMailer.job_complete(@job).deliver   # send email to inform manager
    redirect_to completed_jobs_path
  end
  
  # admin can makr a job active again
  def reactivate_job 
    @job = Job.find_by(id: params[:undo][:job_id])
    @job.update_attribute(:status, 'ongoing')    
    redirect_to @job
  end

  # admin press urgent button
  def mark_as_urgent
    @job = Job.find_by(id: params[:urgent][:job_id])
    @job.update_attribute(:urgent, true)    
    redirect_to root_path
  end 

  private

    # strong parameter
    def job_params
      prepare(short_job?)
    end      

    def prepare(val)
      params[:job][:user_id] = current_user.id     
      params[:job][:urgent] = val     
      params[:job][:status] = "ongoing"
      params.require(:job).permit(:title, :chargeCode, :deadline, 
                                  :description, :user_id, :rig_id,
                                  :urgent, :status, :bootsy_image_gallery_id)  
    end
   
    # check job time less than 3 days
    def short_job?
      date = DateTime.new(params[:job]["deadline(1i)"].to_i, 
                          params[:job]["deadline(2i)"].to_i, 
                          params[:job]["deadline(3i)"].to_i, 
                          params[:job]["deadline(4i)"].to_i, 
                          params[:job]["deadline(5i)"].to_i)                     
      date < Time.now + 3.days
    end 

    def get_job
      @job = Job.find(params[:id])       
    end    

    # only originator can edit, update jobs
    def correct_user_to_edit
      not_allow if (@job.user.id != current_user.id)        
    end

    def correct_user_to_delete
      not_allow if !((current_user.admin?)||(@job.user.id == current_user.id))       
    end

    def not_allow
      flash[:danger] = "You do not have permission to edit job"
      redirect_to active_jobs_path
    end

    def check_time_recorded
      acceptors = Acceptor.where("job_id = ? AND working_time IS NULL", @job.id)
      acceptors.each do |acc| 
        RecordTimeMailer.record_time_email(acc.user, @job).deliver
      end    
    end

   
end
