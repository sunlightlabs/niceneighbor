class HaveController < ApplicationController
  before_filter :authenticate_user!

  def index
    @activities = Have.find_by_user_id(current_user.id)
  end

  def show
    @activity = Have.get(params[:id])
  end

  def new
    @activity = Have.new
  end

  def create
    @activity = Have.new(params[:have])
    if @activity.save
      redirect_to @activity, :notice => "Created offer #{@activity.title}"
    else
      render :action => :new
    end
  end

  def edit
    @activity = Have.get(params[:id])
  end

  def update
    @activity = Have.get(params[:id])
    if @activity.update_attributes(params[:have])
      redirect_to @activity, :notice => "Updated offer #{@activity.title}"
    else
      render :action => :edit
    end
  end

  def destroy
    @activity = Have.get(params[:id])
    if @activity.destroy
      redirect_to :action => :index, :notice => "Deleted offer #{@activity.title}"
    else
      render :action => :edit, :error => "Unable to delete offer #{@activity.title}"
    end
  end

end
