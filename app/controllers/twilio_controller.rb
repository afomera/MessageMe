class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    SMS.new(params[:From]).send("Thanks for messaging tmsg.io! We don't know how to handle your reply! For more help visit tmsg.io and 'Contact Support'")
    # the head :ok tells everything is ok
    head :ok, content_type: "text/html"
  end

end
