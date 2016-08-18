class SessionsController < ApplicationController
  def sign_in
    #Displays sign in form
  end

  def sign_out
    session[:user_id] = nil
    redirect_to root_path
  end

  def authenticate
    user = User.find_by(email: params[:email])
    if user.present?
      if user.authenticate(params[:password])
        flash[:notice] = "Signed in!"
        session[:user_id] = user.id
        redirect_to users_path
      else
        flash[:alert] = "Wrong email or password"
        render :sign_in
      end
    else
      flash[:alert] = "Wrong email or password"
      render :sign_in
    end
  end
end
