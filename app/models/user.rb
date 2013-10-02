class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :avatar, :email, :password,
    :password_confirmation, :remember_me, :account_name
  belongs_to :account
  has_many :comments

  def account_name=(account_name)
  end
  def account_name
  end
  def full_name
    "#{first_name} #{last_name}"
  end
end
