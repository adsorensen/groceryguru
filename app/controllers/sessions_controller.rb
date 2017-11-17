class SessionsController < ApplicationController
  skip_before_action :ensure_logged_in, except: :destroy
  
  def new
  end
  
  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      log_in(user)
      redirect_to :root
    else
      flash.now[:danger] = 'Invalid credentials'
      render :new
    end
  end

  def destroy
    log_out
    flash[:notice] = 'You have been logged out.'
    redirect_to new_session_path
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
