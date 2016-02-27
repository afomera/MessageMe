class ScheduledMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_scheduled_message, only: [:edit, :update, :destroy]

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
      redirect_to scheduled_messages_path, notice: 'Scheduled Message Saved!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @scheduled_message.update(scheduled_message_params)
      redirect_to scheduled_messages_path, notice: 'That scheduled message has been updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @scheduled_message.destroy
    redirect_to scheduled_messages_path, notice: 'That scheduled message has been deleted.'
  end

  private
    def scheduled_message_params
      params.require(:scheduled_message).permit(:group_id, :body, :scheduled_at)
    end

    def set_scheduled_message
      @scheduled_message = ScheduledMessage.find(params[:id])
    end
end
