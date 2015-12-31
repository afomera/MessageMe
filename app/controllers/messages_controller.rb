class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @message = current_user.messages.build
  end

  def create
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

  private
    def messages_params
      params.require(:message).permit(:to_phone_number, :body, :ip_address)
    end

end
