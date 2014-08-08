class AccessController < ApplicationController
  before_action :confirm_logged_in, except: [:attempt_login, :logout]

  #attempts a user_login
  def attempt_login
    if params[:user_name].present? && params[:password].present?
      found_user = User.find_by(user_name: params[:user_name])
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:user_name] = authorized_user.user_name
      session[:user_is_admin?] = authorized_user.is_admin
      flash[:notice] = "Welcome #{session[:user_name]}!"
    else
      flash[:notice] = 'Invalid username/password combination'
    end
    redirect_to root_path

  end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    session[:user_is_admin?] = nil
    flash[:notice] = 'Logged out'
    redirect_to root_path
  end

end