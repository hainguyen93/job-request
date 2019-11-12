class PasswordResetsController < ApplicationController
  
  before_action :get_user_edit,   only: :edit
  before_action :get_user_update,   only: :update
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  # page to enter email
  def new
  end

  # send reset password email
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest   
      @user.send_password_reset_email
      flash[:info] = "Please check your email to see password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Sorry ! Email address not found"
      render :new
    end
  end

  # form to type new password
  def edit
  end

  # update new password
  def update
    if password_not_match?
      flash.now[:danger] = "Password and Confirmation do not match"
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset successfully."
      redirect_to active_jobs_path
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end  

    def password_not_match?
      params[:user][:password] != params[:user][:password_confirmation]
    end   

    def get_user_edit
      @user = User.find_by(email: params[:email])
    end

    def get_user_update
      @user = User.find_by(email: params[:user][:email])
    end

    # Confirms a valid user.
    def valid_user
      unless (@user && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # Checks expiration of reset token.
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
