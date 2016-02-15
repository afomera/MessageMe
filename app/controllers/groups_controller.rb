class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:edit, :update, :destroy]

  def index
    @groups = current_user.groups.all
  end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      redirect_to groups_path, notice: 'Your group has been added!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: 'That group has been successfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: 'That group has been removed.'
  end

  private
    def set_group
      @group = current_user.groups.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name, :description)
    end
end
