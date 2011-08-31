class NeighborhoodsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @location = get_location
    @distance = get_distance
    @neighborhoods = Neighborhood.within(@distance, :origin => @loc)
    if current_user
      @my_neighborhoods = current_user.neighborhoods
    end
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])

    @map = Mapstraction.new("map", :google)
    @map.control_init(:small => true)
    @map.center_zoom_init([@neighborhood.lat,@neighborhood.lng],settings['GEOCODER_DEFAULT_ZOOM'])
    @map.marker_init(Marker.new([@neighborhood.lat,@neighborhood.lng], :label => @neighborhood.name))
  end

  def new
    @neighborhood = Neighborhood.new
  end

  def create
    @neigborhood = Neighborhood.new(params[:neighborhood])
    @neighborhood.created_by = current_user.id
    if @neighborhood.save
      # create membership for this user as well
      @membership = current_user.memberships.create(:neighborhood_id => @neighborhood.id, :user_id => current_user.id, :is_admin => true)
      @membership.save!
      redirect_to @neighborhood, :notice => "Created neighborhood #{@neighborhood.name}"
    else
      render :action => :new
    end
  end

  def edit
    @neighborhood = Neighborhood.find(params[:id])
  end

  def update
    @neighborhood = Neighborhood.find(params[:id])

    if @neighborhood.update_attributes(params[:neighborhood])
      redirect_to @neighborhood, :notice => "Updated neighborhood #{@neighborhood.name}"
    else
      render :action => :edit
    end
  end

  def join
    @neighborhood = Neighborhood.find(params[:id])
    @membership = current_user.memberships.create(:neighborhood_id => @neighborhood.id)
    if @membership.save
      redirect_to @neighborhood, :notice => "Joined neighborhood #{@neighborhood.name}"
    else
      redirect_to @neighborhood, :error => "Unable to join neighborhood #{@neighborhood.name}"
    end
  end

  def leave
    @neighborhood = Neighborhood.find(params[:id])
    @membership = current_user.memberships.find_by_neighborhood_id(@neighborhood.id)
    if @membership.destroy
      redirect_to @neighborhood, :notice => "Left neighborhood #{@neighborhood.name}"
    else
      redirect_to @neighborhood, :error => "Unable to leave neighborhood #{@neighborhood.name}"
    end
  end

end
