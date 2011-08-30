class SearchController < ApplicationController

  def by_activity
    render 'results'
  end

  def by_activity_for_location
    render 'results_by_location'
  end

end
