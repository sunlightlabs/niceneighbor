class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  def show
    @user = User.find_by_username(params[:id])
    @user = User.find(params[:id]) if@user.empty?
    not_found if @user.empty?
  end

  def edit
  end

  def update
    if current_user.update_attributes(params[:user])
      flash[:notice] = 'Profile updated.'
    end
    render :action => :edit
  end

  def destroy
    if current_user.destroy
      flash[:notice] = 'Your account has been deleted.'
      redirect_to root_path
    else
      flash[:error] = 'Unable to delete your account.'
      redirect_to profile_path
    end
  end

end
