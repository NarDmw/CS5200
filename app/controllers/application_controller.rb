class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def confirm_logged_in
    if session[:user_id]
      true
    else
      flash[:notice] = 'Please log in.'
      redirect_to root_path
      false #halts the before_action
    end
  end

  def permit_only_admin
    if session[:user_is_admin?]
      true
    else
      flash[:error] = 'You do not have permission to do that.'
      redirect_to root_path
      false
    end
  end
end
