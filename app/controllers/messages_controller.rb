class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    # Send the text here?
    phone_number = params[:phone_number]
    message_body = params[:body]

    SMS.new(phone_number).send message_body

    redirect_to root_path, notice: "Your message has been sent, thank you!"
  end
end
