class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :phone_number
  has_many :contacts
  has_many :contact_groups, :through => :contacts
  has_many :groups
  has_many :messages
  has_many :scheduled_messages

  validates :first_name, presence: true
  validates :last_name, presence: true
  #validates :quota_limit_check, message: "You've exceeded your quota"

  def exceeded_quota_limit?
    self.quota > self.quota_limit
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
