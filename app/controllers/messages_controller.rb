class MessagesController < ApplicationController

  def create
    @message = Message.new(params[:message])
    @message.user_id = current_user.id
    @message.activity_id = extract_id_from params
    if @message.save
      redirect_to @message.activity, :notice => "Your message was sent"
    else
      redirect_to @message.activity, :error => "There was a problem sending your message"
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      redirect_to "#{@message.activity.type.downcase}_path".constantize! @message.activity.id, :notice => "Message deleted"
    else
      redirect_to "#{@message.activity.type.downcase}_path".constantize! @message.activity.id, :notice => "Unable to delete message"
    end
  end

  private

  def extract_id_from(params)
    nil
    return params[:need_id] if !params[:need_id].blank?
    return params[:have_id] if !params[:have_id].blank?
  end

end
