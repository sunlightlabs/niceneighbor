class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:id]) ||
            User.find_by_phone(params[:id]) ||
            User.find_by_email(params[:id]) ||
            not_found
  end
end
