class SessionsController < ApplicationController
  def create
    p session_params
    user = User.find_by_credentials(session_params[:email], session_params[:password])
    if user
      log_in_user!(user)
      redirect_to new_session_url
    else
      flash.now[:errors] = ["Invalid login"]
    end
  end

  def new
    render :new
  end

  def destroy
    log_out!
    redirect_to new_user_url
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

end