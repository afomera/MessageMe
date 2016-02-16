class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :contacts

  has_many :contacts, through: :contact_groups, dependent: :destroy
  has_many :contact_groups
end
