class SessionsController < ApplicationController
  skip_before_action :require_user, only: [ :new, :create ]
  def new
  end

  def create
    user = User.find_by(user: params[:user])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome #{user.name}! You have successfully logged in."
    else
      flash.now[:alert] = "Invalid user or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    puts "entrou no destroy"
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path, notice: "Logged out successfully."
  end
end
