class SessionsController < ApplicationController
  skip_before_action :require_user, only: [ :new, :create ]
  before_action :redirect_if_logged_in, only: [ :new ]

  def new
  end

  def create
    user = User.find_by(user: params[:user])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboards_path, notice: "Welcome #{user.name}! You have successfully logged in."
    else
      flash.now[:alert] = "Invalid user or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to login_path, notice: "Logged out successfully."
  end
end
