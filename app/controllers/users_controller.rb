class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit,:update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
   @user = User.new(user_params)    # Not the final implementation!
   if @user.save
     @user.send_verification_email
     flash[:info] = "Please check your email to activate your account."
     redirect_to root_url
   else
     flash.now[:danger] = "Could not save client"
     render 'new'
   end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated successfully"
      redirect_to @user
    else
      flash[:danger] = "Profile not updated"
      @user.reload
      render 'edit'
    end
  end

  def logged_in_user
   unless logged_in?
     flash[:danger]="Please log in first"
     redirect_to login_url
   end
  end
  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  private

  def user_params
   params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

end
