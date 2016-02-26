class ScheduledMessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @scheduled_messages = current_user.scheduled_messages.all.order("created_at ASC")
  end

  def new
    @scheduled_message = current_user.scheduled_messages.build
  end

  def create
    @scheduled_message = current_user.scheduled_messages.build(scheduled_message_params)
    @scheduled_message.status = 'pending'
    if @scheduled_message.save
      redirect_to root_path, notice: 'Scheduled Message Saved!'
    else
      render 'new'
    end
  end

  private
    def scheduled_message_params
      params.require(:scheduled_message).permit(:group_id, :body, :scheduled_at)
    end
end
