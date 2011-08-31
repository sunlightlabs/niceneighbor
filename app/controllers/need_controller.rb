class NeedController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    @activities = Need.find_by_user_id(current_user.id)
  end

  def show
    @activity = Need.find(params[:id])
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
    @activity = Need.new
  end

  def create
    @categories = Category.where('id IN (?)', params[:need][:categories])
    params[:need][:categories] = @categories
    @activity = Need.new(params[:need])
    @activity.user_id = current_user.id
    if @activity.save
      redirect_to @activity, :notice => "Created request #{@activity.title}"
    else
      render :action => :new
    end
  end

  def edit
    @activity = Need.find(params[:id])
  end

  def update
    @activity = Need.find(params[:id])
    if @activity.update_attributes(params[:Need])
      redirect_to @activity, :notice => "Updated request #{@activity.title}"
    else
      render :action => :edit
    end
  end

  def destroy
    @activity = Need.find(params[:id])
    if @activity.destroy
      redirect_to :action => :index, :notice => "Deleted request #{@activity.title}"
    else
      render :action => :edit, :error => "Unable to delete request #{@activity.title}"
    end
  end

  def open
    @activity = Need.find(params[:id])
    if @activity.user == current_user
      @activity.is_active = true
      if @activity.save
        redirect_to @activity, :notice => "Reopened this request"
      else
        redirect_to @activity, :notice => "Unable to reopen this request"
      end
    else
      redirect_to @activity, :error => "You don't Need permission to edit this request"
    end
  end

  def close
    @activity = Need.find(params[:id])
    if @activity.user == current_user
      @activity.is_active = false
      if @activity.save
        redirect_to @activity, :notice => "Closed this request"
      else
        redirect_to @activity, :notice => "Unable to close this request"
      end
    else
      redirect_to @activity, :error => "You don't Need permission to edit this request"
    end
  end

end
