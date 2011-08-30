class SearchController < ApplicationController

  def results
    @location = get_location
    @distance = get_distance
    @query = params[:query] || ''
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
  end

end
