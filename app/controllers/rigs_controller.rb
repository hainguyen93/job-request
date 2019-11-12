class RigsController < ApplicationController 
 
  before_action :logged_in_user
  before_action :admin_user
  before_action :get_rig, only: [:edit, :update, :destroy]

  # register page
  def new
    @rig = Rig.new
  end

  def create
    @rig = Rig.new(rig_params)
    if @rig.save
      flash[:success] = 'RIG Code has been successfully added'
      redirect_to rigs_path   #redirect to index page
    else
      render :new
    end
  end

  # edit rig page
  def edit
  end
 
  # update action
  def update
    if @rig.update_attributes(rig_params) 
      flash[:success] = "Rig description updated successfully"
      redirect_to rigs_path
    else
      render :edit    # fail to update
    end
  end

  # list all rigs
  def index
    @rigs = Rig.all.paginate(page: params[:page], per_page: 30)
  end

  # remove rig
  def destroy
    @rig.destroy
    flash[:success] = "Rig has been successfully deleted"
    redirect_to rigs_path
  end

  private
    def rig_params
      params.require(:rig).permit(:code)
    end

    def get_rig
      @rig = Rig.find(params[:id])       
    end

end
