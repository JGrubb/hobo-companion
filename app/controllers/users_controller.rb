class UsersController < ApplicationController
  before_filter :authorize_admin
  
  def index
    @users = User.all
  end
  
  def update
    @user = User.find params[:id]
  end
  
  def make_editor
    @user = User.find(params[:user_id])
    @user.is_editor = true
    @user.save
    flash[:alert] = "#{@user.email} is now an editor."
    redirect_to users_path
  end
end
