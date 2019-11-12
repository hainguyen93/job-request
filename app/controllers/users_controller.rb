class UsersController < ApplicationController  
   
  before_action :logged_in_user
  before_action :correct_user_to_edit, only: [:edit, :update]
  before_action :admin_user, only: [:new, :create, :disable_user]
  before_action :get_user, only: [:edit, :update]
 
  def new
    @user = User.new    
  end

  # create new user
  def create
    @user = User.new(user_params)
    if @user.save 
      flash[:success] = "New user has been successfully registered"
      redirect_to users_path  #redirect to index page
    else
      render :new
    end
  end 

  # edit user page
  def edit
  end
 
  # update user info.
  def update
    if @user.update_attributes(edit_user_params) 
      flash[:success] = "User information updated successfully"
      redirect_to users_path
    else
      render :edit    # fail to update
    end
  end

  # all users page
  def index
    @admins = User.where(disabled: false, admin: true).paginate(page: params[:admins_page], per_page: 20)
    @users = User.where(disabled: false, admin: false).paginate(page: params[:users_page], per_page: 20)
  end

  # disable user
  def disable_user
    @user = User.find(params[:disable_user][:user_id])
    @user.update_attribute(:disabled, true)
    flash[:success] = "User #{@user.name} gets deleted"
    redirect_to users_path
  end


  private

    # user params, update normal user info.
    def user_params
      prepare(false)       
    end
    
    def edit_user_params           
      prepare(@user.admin)
    end

    def prepare(val)
      params[:user][:disabled] = false
      params[:user][:admin] = val
      params.require(:user).permit(:name, :email, :username, :password, 
                                   :password_confirmation, :disabled, :admin)
    end

    # only admin can edit any user, user can only edit their own information 
    def correct_user_to_edit
      if !((current_user.admin?)||(params[:id].to_f == current_user.id))
        flash[:danger] = "You do not have permission to edit this user information"
        redirect_to users_path
      end
    end

    def get_user
      @user = User.find(params[:id])       
    end
	
end


