class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  NOTES = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']

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
  end

  def notes_in_key_and_scale(key, scale)
    key = NOTES.index(key)

    scale = scale.degrees.map{ |deg| (deg + key) % 12 }
    notes = scale.map{ |note| NOTES[note] }
    notes
  end

  helper_method :current_user, :user_logged_in?
end
