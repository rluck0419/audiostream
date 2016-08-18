class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :destroy]

  def index
    render locals: { users: User.all }
  end

  def show
    if User.exists?(params[:id])
      render locals: { user: User.find(params[:id]) }
    else
      render html: 'User not found', status: 404
    end
  end

  def new
    render locals: { user: User.new }
  end

  def create
    user = User.new(user_params)
    if user.save
      sign_in_new_user(user)
      redirect_to root_path
    else
      render :new, locals: { user: user }
    end
  end

  def edit
    render locals: { user: User.find(params[:id]) }
  end

  def update
    if User.find(params[:id])
      user = User.find(params[:id])
      if user.update(user_params)
        redirect_to user
      else
        render :edit
      end
    else
      render html: 'User not found', status: 404
    end
  end

  def destroy
    if User.exists?(params[:id])
      User.destroy(params[:id])
      flash[:notice] = "User destroyed"
      redirect_to user
    else
      flash[:alert] = "There was an error - please try again"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
