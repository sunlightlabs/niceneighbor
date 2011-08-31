module ActivityHelper

  def activity_classname_for(activity)
    activity.type=='Have' ? 'have' : 'need'
  end

  def activity_path(activity)
    if activity.type == 'Have'
      have_path activity
    else
      need_path activity
    end
  end

  def open_activity_path(activity)
    if activity.type == 'Have'
      open_have_path activity
    else
      open_need_path activity
    end
  end

  def close_activity_path(activity)
    if activity.type == 'Have'
      close_have_path activity
    else
      close_need_path activity
    end
  end

  def activity_message_path(activity)
    if activity.type == 'Have'
      have_message_path activity
    else
      need_message_path activity
    end
  end

  def activity_messages_path(activity)
    if activity.type == 'Have'
      have_messages_path activity
    else
      need_messages_path activity
    end
  end

  def activity_status_label_for(activity)
    if activity.is_active
      activity.type == 'Have' ? 'has' : 'needs'
    else
      "has closed this " + activity.type == 'Have' ? 'offer' : 'request'
    end
  end

  def activity_status_message_for(activity)
    if !activity.is_active
      "This " + activity.type == 'Have' ? 'offer' : 'request' + " is no longer active."
    end
  end

  def activity_type_for(activity)
    if activity.type == 'Have'
      'offer'
    else
      'request'
    end
  end

  def activity_status_button_for(activity)
    if activity.user == current_user
      if activity.is_active
        render 'activities/close_button', :activity => activity
      else
        render 'activities/open_button', :activity => activity
      end
    end
  end

  def activity_delete_button_for(activity)
    if activity.user == current_user
      render 'activities/delete_button', :activity => activity
    end
  end

end