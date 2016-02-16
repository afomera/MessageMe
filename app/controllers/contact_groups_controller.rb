class ContactGroupsController < ApplicationController
  before_action :authenticate_user!

  def create
    @contact = Contact.find(params[:contact_id])
    @group = Group.find(params[:group_id])
    ContactGroup.find_or_create_by(contact: @contact, group: @group)
    redirect_to contacts_path, notice: "Added #{@contact.first_name} to #{@group.name}"
  end

end
