class SearchController < ApplicationController

  def redirect
    # puts search_results_path(:type => params[:type], :location => params[:location], :query => params[:query])
    other = []
    if params[:query]
      other.push params[:query]
    end
    if params[:location]
      other.push('near').push(params[:location])
    end
    params[:other] = other.join('/')
    redirect_to search_results_path :activity => params[:activity], :other => params[:other]
  end

  def results
    other = params[:other].split('/') rescue []
    params[:query] = other[0] rescue ''
    params[:location] = other[2] rescue nil

    @location = get_location
    @distance = get_distance
    @query = params[:query]
    if params[:activity] == 'have'
      @type = 'Have'
    elsif params[:activity] == 'need'
      @type = 'Need'
    else
      @type = nil
    end
      @activities = Activity.within(@distance, :origin => @location).where('title LIKE ?', "%#{@query}%")
    if @type
      @activities = @activities.where('type=?', @type)
    end

    if !@activities.empty?
      geo = Geokit::Geocoders::MultiGeocoder.geocode(@location)
      @map = Mapstraction.new("map", :google)
      @map.control_init(:small => true)
      @map.center_zoom_init([geo.lat,geo.lng], 11)
      @activities.each do |activity|
        @map.marker_init(Marker.new([activity.lat,activity.lng], :label => activity.preferred_location, :info_bubble => "<a href='#{url_for activity}'><img src='#{activity.user.avatar_url}' width='24' height='24' /> #{activity.title} near #{activity.preferred_location}</a>"))
      end
    end

  end

end
