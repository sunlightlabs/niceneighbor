class SiteController < ApplicationController
  def index
    @location = get_location
    @distance = get_distance
    @neighborhoods = Neighborhood.within(@distance, :origin => @loc)
    render :layout => 'home'
  end

  def about
  end

  def terms
  end

end
