class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @message = @user.messages.build
  end
end
