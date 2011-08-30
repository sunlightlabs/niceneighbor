class NeedController < ApplicationController
  before_filter :authenticate_user!

  def index
    @activities = Need.find_by_user_id(current_user.id)
  end

  def show
    @activity = Need.get(params[:id])
  end

  def new
    @activity = Need.new
  end

  def create
    @activity = Need.new(params[:Need])
    if @activity.save
      redirect_to @activity, :notice => "Created request #{@activity.title}"
    else
      render :action => :new
    end
  end

  def edit
    @activity = Need.get(params[:id])
  end

  def update
    @activity = Need.get(params[:id])
    if @activity.update_attributes(params[:Need])
      redirect_to @activity, :notice => "Updated request #{@activity.title}"
    else
      render :action => :edit
    end
  end

  def destroy
    @activity = Need.get(params[:id])
    if @activity.destroy
      redirect_to :action => :index, :notice => "Deleted request #{@activity.title}"
    else
      render :action => :edit, :error => "Unable to delete request #{@activity.title}"
    end
  end

end
