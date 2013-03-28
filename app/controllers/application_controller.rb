class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def require_editor
    authenticate_user!
    unless current_user.is_editor || current_user.is_admin
      flash[:error] = "Editor or GTFO."
      redirect_to root_path
    end
  end
  
  def authorize_admin
    authenticate_user!
    unless current_user.is_admin
      flash[:error] = "Admin or GTFO."
      redirect_to root_path
    end
  end
end
