class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :phone_number
  has_many :contacts
  has_many :messages

  validates :first_name, presence: true
  validates :last_name, presence: true


  def full_name
    "#{first_name} #{last_name}"
  end
end
