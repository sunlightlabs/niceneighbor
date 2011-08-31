module ApplicationHelper
  def location_for(user)
    "#{session['geo_location'].city}, #{session['geo_location'].state}" rescue nil ||
    "#{current_user.location}, #{current_user.city}, #{current_user.state}"
  end
end
