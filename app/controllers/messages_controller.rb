class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @message = current_user.messages.build
  end

  def create

    if params[:message][:group_id].present?
      @group = Group.find(params[:message][:group_id])

      if params[:message][:body].blank?
        redirect_to new_message_path, notice: 'Sorry you need to make sure you enter a message'
      else
        @group.contacts.each do |c|
          Message.create(
            body: params[:message][:body], to_phone_number: c.phone_number,
            status: 'pending', ip_address: request.remote_ip, user: current_user
          )
        end
        # Assume everything went okay sending all those messages
        redirect_to root_path, notice: "Your message has been sent to #{@group.name}!"
      end

    else
      # Group ID wasn't passed in from the form, so continue on as normal
      @message = current_user.messages.build(messages_params)
      @message.status = "pending"
      @message.ip_address = request.remote_ip

      if @message.save
        # Notify the user the message has been sent.
        # It will be sent in an after_commit callback in the model.
        redirect_to root_path, notice: "Your message has been sent, thank you!"
      else
        render 'new'
      end
    end

  end

  private
    def messages_params
      params.require(:message).permit(:to_phone_number, :body, :ip_address)
    end

end
