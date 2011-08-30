class NeighborhoodsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @location = get_location
    @distance = get_distance
    @neighborhoods = Neighborhood.within(@distance, :origin => @loc)
    if current_user
      @my_neighborhoods = Neighborhood.find_by_user_id(current_user)
    end
  end

  def show
    @neighborhood = Neighborhood.get(params[:id])
  end

  def new
    @neighborhood = Neighborhood.new
  end

  def create
    @neigborhood = Neighborhood.new(params[:neighborhood])
    @neighborhood.created_by = current_user.id rescue nil
    if @neighborhood.save
      redirect_to @neighborhood, :notice => "Created neighborhood #{@neighborhood.name}"
    else
      render :action => :new
    end
  end

  def edit
    @neighborhood = Neighborhood.get(params[:id])
  end

  def update
    @neighborhood = Neighborhood.get(params[:id])

    if @neighborhood.update_attributes(params[:neighborhood])
      redirect_to @neighborhood, :notice => "Updated neighborhood #{@neighborhood.name}"
    else
      render :action => :edit
    end
  end

end
