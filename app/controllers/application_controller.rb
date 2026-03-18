class ApplicationController < ActionController::Base
  before_action :require_user

  helper_method :current_user, :logged_in?

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
    session[:user_id] = nil if @current_user.nil?
    @current_user
  end

  def logged_in?
    !!current_user
  end

  def redirect_if_logged_in
    redirect_to dashboards_path if logged_in?
  end

  private

  def require_user
    return if logged_in?

    flash[:alert] = "Você precisa estar logado para acessar esta página."
    redirect_to login_path
  end
end
