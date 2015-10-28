class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    # Send the text here?
  end
end
