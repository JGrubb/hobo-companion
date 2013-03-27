class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def require_editor
    authenticate_user!
    unless current_user.is_editor || current_user.is_admin
      flash[:alert] = "Editor or GTFO."
      redirect_to root_path
    end
  end
end
