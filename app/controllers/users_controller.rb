class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  def show
    @user = User.find_by_username(params[:id]) ||
            User.find_by_phone(params[:id]) ||
            User.find_by_email(params[:id]) ||
            not_found
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
      flash[:warning] = 'Unable to delete your account.'
      redirect_to profile_path
    end
  end

end
