class ApplicationController < ActionController::Base
  # Adiciona isto para proteger TODAS as páginas por padrão
  before_action :require_user

  helper_method :current_user, :logged_in?

def current_user
  if session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
    # Se o ID existe na sessão mas não no banco, limpamos a sessão
    session[:user_id] = nil if @current_user.nil?
  end
  @current_user
end

  def logged_in?
    !!current_user
  end

  private

  def require_user
    if !logged_in?
      flash[:alert] = "Você precisa estar logado para acessar esta página."
      redirect_to login_path # Garante que vai para a tela de login
    end
  end
end
