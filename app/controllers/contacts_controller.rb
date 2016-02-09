class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    # Contacts belongs_to user so only show the logged in users contacts
    @contacts = current_user.contacts.all
  end

  def new
    @contact = current_user.contacts.build
  end

  def create
    @contact = current_user.contacts.build(contacts_params)
    if @contact.save
      redirect_to contacts_path, notice: 'You have added a contact!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @contact.update(contacts_params)
      redirect_to contacts_path, notice: 'That contact has been updated!'
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path, notice: 'That contact has been removed'
  end

  private
    def contacts_params
      params.require(:contact).permit(:first_name, :last_name, :phone_number, :email_address)
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end

end
