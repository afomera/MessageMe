class Contact < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :first_name, :last_name, :phone_number

  def full_name_with_phone
    "#{first_name} #{last_name} - #{phone_number}"
  end
end
