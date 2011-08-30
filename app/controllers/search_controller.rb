class SearchController < ApplicationController

  def results
    @loc = params[:location] || session['geo_location'] || settings['GEOCODER_DEFAULT_LOCATION']
    @distance = params[:distance] || settings['GEOCODER_DEFAULT_DISTANCE']
    @type = params[:activity] == 'need' ? 'Have' : 'Need'
    @query = params[:query]
    @activities = Activity.within(@distance, :origin => @loc).where('title LIKE ? AND type=?', "%#{@query}%", @type)
    @error = "No requests found matching '#{@query}' near #{@loc}"

    render 'results'
  end

end
