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
    UserInstrument.create!(user: user, instrument: Instrument.all.first)
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

      if params[:instrument].values.empty?
        user.instruments.destroy_all
      else
        user.instruments = params[:instrument].values.map{ |id| Instrument.find(id) }
      end

      if params[:chord].values.empty?
        user.chords.destroy_all
      else
        user.chords = params[:chord].values.map{ |id| Chord.find(id) }
      end

      if params[:scale].values.empty?
        user.scales.destroy_all
      else
        user.scales = params[:scale].values.map{ |id| Scale.find(id) }
      end

      if params[:reverb].values.empty?
        user.reverbs.destroy_all
      else
        user.reverbs = params[:reverb].values.map{ |id| Reverb.find(id) }
      end

      if user.update(user_params)
        redirect_to root_path
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
