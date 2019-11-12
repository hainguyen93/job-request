class CommentsController < ApplicationController

  before_action :logged_in_user  
  before_action :correct_user_to_delete, only: :destroy

  # create comments
  def create
    if (params[:comment][:content].present? || params[:files])
      @comment = Comment.new(comment_params)
      @comment.save    
      if params[:files]
        params[:files].each do |file|
          @comment.comment_files.create(upload: file)   
        end
      end     
    end
    @job = Job.find_by(id: params[:comment][:job_id])
    redirect_to @job 
  end

  # delete comment
  def destroy
    @cmt.destroy  # upload files automatically get destroyed
    redirect_to @job
  end

  private

    #strong parameter
    def comment_params
      params[:comment][:user_id] = current_user.id      
      params.require(:comment).permit(:user_id, :job_id, :content, :bootsy_image_gallery_id)
    end

    # only admin and cmt originator can remove it
    def correct_user_to_delete
      @cmt = Comment.find(params[:comment][:cmt_id])
      @job = Job.find_by(id: params[:comment][:job_id]) 
      if !((current_user.admin?)||(@cmt.user.id == current_user.id)) 
        flash[:danger] = "You do not have permission to delete comment"        
        redirect_to @job
      end
    end

end
