class UsersController < ApplicationController
  skip_before_action :require_user, only: [ :new, :create ]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: "User created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

    def update
      @user = User.find(params[:id])

      if @user.update(user_params)
        redirect_to @user, notice: "Status update confirmed."
      else
        render :show, status: :unprocessable_entity
      end
    end

  private

  def user_params
    params.require(:user).permit(:name, :user, :email, :password, :password_confirmation)
  end
end
