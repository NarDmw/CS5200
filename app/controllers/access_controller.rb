class AccessController < ApplicationController
  before_action :confirm_logged_in, except: [:login, :attempt_login, :logout]

  def index
  end

  #TODO fix
  def login
  end

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
      flash[:notice] = "Welcome #{session[:user_name]}!"
      redirect_to action: :login
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to :back
    end

  end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    flash[:notice] = 'Logged out.'
    redirect_to action: :login
  end

end
