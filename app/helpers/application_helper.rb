module ApplicationHelper

  def membership_classname_for(neighborhood)
    'member' if current_user.is_member_of? neighborhood
  end

  def membership_button_for(neighborhood)
    if current_user
      if current_user.is_member_of? neighborhood
        render 'neighborhoods/leave_button', :neighborhood=>neighborhood
      else
        render 'neighborhoods/join_button', :neighborhood=>neighborhood
      end
    end
  end

end
