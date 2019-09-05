class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save # make sure to not use "save!"
      log_in_user!(@user)
      redirect_to new_user_url
    else
      redirect_to new_user_url
      flash.now[:errors] = "Invalid login" 
    end
  end
 
  def show
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end