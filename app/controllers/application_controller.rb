class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  #confirms the user is logged in
  def confirm_logged_in
    if session[:user_id]
      true
    else
      flash[:notice] = 'Please log in.'
      redirect_to root_path
      false #halts the before_action
    end
  end

  def restrict_permissions(user_id)
    #checks to see if the user has permissions to view the current controller#action
    if session[:user_id] == user_id  || session[:user_is_admin?]
      true
    else
      flash[:error] = 'You do not have permission to do that.'
      redirect_to root_path
      false
    end
  end

  #hashes the activerecord_relation from ids to the element string
  def hash_id_to_s(actrec_relation)
    actrec_relation.inject({}){ |hash, elem| hash[elem.id]=elem.to_s; hash }
  end
end
