class SessionsController < ApplicationController

  skip_before_action :ensure_login, only: [:new,:create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id]=user.id
      redirect_to posts_path,notice: "Logged in successfully"
    else
      redirect_to root_path, alert: "Invalid username/password"
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "You have been logged out"
  end
end