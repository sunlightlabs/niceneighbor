class SearchController < ApplicationController

  def results
    @loc = params[:location] ||
           "#{session['geo_location'].city}, #{session['geo_location'].state}" ||
           settings['GEOCODER_DEFAULT_LOCATION']
    @distance = params[:distance] || settings['GEOCODER_DEFAULT_DISTANCE']
    @query = params[:query]
    if params[:activity] == 'have'
      @type = 'Have'
    elsif params[:activity] == 'need'
      @type = 'Need'
    else
      @type = nil
    end
      @activities = Activity.within(@distance, :origin => @loc).where('title LIKE ?', "%#{@query}%")
    if @type
      @activities = @activities.where('type=?', @type)
    end
    @error = "No requests found matching '#{@query}' near #{@loc}"

    render 'results'
  end

end
