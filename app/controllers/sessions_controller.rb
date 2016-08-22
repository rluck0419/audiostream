class SessionsController < ApplicationController
  def sign_in
    #Displays sign in form
  end

  def sign_out
    session[:user_id] = nil
    cookies.signed[:user_id] = nil
    redirect_to root_path
  end

  def authenticate
    if user_logged_in?
      if user.authenticate(params[:password])
        flash[:notice] = "Signed in!"
        session[:user_id] = user.id
        cookies.signed[:user_id] = user.id
        redirect_to root_path
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
