class Contact < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :first_name, :last_name, :phone_number
  has_many :contact_groups
  has_many :groups, through: :contact_groups

  def full_name_with_phone
    "#{first_name} #{last_name} - #{phone_number}"
  end
end
