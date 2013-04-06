class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
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
  
  def karma_check(entity, user, points)
    unless entity.updated_by == current_user.id
      entity.updated_by = current_user.id
      User.bump_karma(points, current_user)
    end
  end
end
