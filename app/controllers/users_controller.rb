class UsersController < ApplicationController
  before_filter :authorize_admin
  
  def index
    @users = User.all
  end
  
  def update
    @user = User.find params[:id]
  end
end
