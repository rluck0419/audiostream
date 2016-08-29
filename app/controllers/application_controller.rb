class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    User.find_by(id: session[:user_id])
  end

  def user_logged_in?
    current_user.present?
  end

  def authenticate_user!
    unless user_logged_in?
      flash[:alert] = "You must be signed in to do that."
      redirect_to sessions_sign_in_path
    end
  end

  def sign_in_new_user(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
  end

  helper_method :current_user, :user_logged_in?
end
