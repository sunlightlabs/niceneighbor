class HaveController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    @activities = current_user.activities.where(:type => "Have")
    if @activities.blank?
      redirect_to :action => :new
    end
  end

  def show
    @activity = Have.find(params[:id])
    if @activity.is_active && current_user && current_user != @activity.user
      @message = Message.new(:activity_id => @activity.id, :user_id => current_user.id)
    end

    geo = Geokit::Geocoders::MultiGeocoder.geocode(@activity.preferred_location)
    if geo.success?
      @map = Mapstraction.new("map", :google)
      @map.control_init(:small => true)
      @map.center_zoom_init([geo.lat,geo.lng], settings['GEOCODER_DEFAULT_ZOOM'].to_i)
      @map.marker_init(Marker.new([geo.lat,geo.lng], :label => @activity.preferred_location))
    end
  end

  def new
    @activity = Have.new
    @categories = Category.all
  end

  def create
    @categories = Category.where('id IN (?)', params[:have][:categories])
    params[:have][:categories] = @categories
    @activity = Have.new(params[:have])
    @activity.user_id = current_user.id
    if @activity.save
      redirect_to @activity, :notice => "Created offer #{@activity.title}"
    else
      render :action => :new
    end
  end

  def edit
    @activity = Have.find(params[:id])
  end

  def update
    @activity = Have.find(params[:id])
    if @activity.update_attributes(params[:have])
      redirect_to @activity, :notice => "Updated offer #{@activity.title}"
    else
      render :action => :edit
    end
  end

  def destroy
    @activity = Have.find(params[:id])
    if @activity.destroy
      redirect_to :action => :index, :notice => "Deleted offer #{@activity.title}"
    else
      render :action => :edit, :error => "Unable to delete offer #{@activity.title}"
    end
  end

  def open
    @activity = Have.find(params[:id])
    if @activity.user == current_user
      @activity.is_active = true
      if @activity.save
        redirect_to @activity, :notice => "Reopened this offer"
      else
        redirect_to @activity, :notice => "Unable to reopen this offer"
      end
    else
      redirect_to @activity, :error => "You don't have permission to edit this offer"
    end
  end

  def close
    @activity = Have.find(params[:id])
    if @activity.user == current_user
      @activity.is_active = false
      if @activity.save
        redirect_to @activity, :notice => "Closed this offer"
      else
        redirect_to @activity, :notice => "Unable to close this offer"
      end
    else
      redirect_to @activity, :error => "You don't have permission to edit this offer"
    end
  end

end
