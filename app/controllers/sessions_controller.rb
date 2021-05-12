class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email]
    if user&.authenticate params[:session][:password]
      log_in user
      redirect_to root_path
    else
      flash[:danger] = t :incorrect_email_password
      redirect_to login_path
    end
  end

  def destroy
    log_out
  end
end
