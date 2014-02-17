# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`first_name`**              | `string(255)`      |
# **`last_name`**               | `string(255)`      |
# **`avatar`**                  | `string(255)`      |
# **`account_id`**              | `integer`          |
# **`email`**                   | `string(255)`      | `default(""), not null`
# **`encrypted_password`**      | `string(255)`      | `default(""), not null`
# **`reset_password_token`**    | `string(255)`      |
# **`reset_password_sent_at`**  | `datetime`         |
# **`remember_created_at`**     | `datetime`         |
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`current_sign_in_at`**      | `datetime`         |
# **`last_sign_in_at`**         | `datetime`         |
# **`current_sign_in_ip`**      | `string(255)`      |
# **`last_sign_in_ip`**         | `string(255)`      |
# **`confirmation_token`**      | `string(255)`      |
# **`confirmed_at`**            | `datetime`         |
# **`confirmation_sent_at`**    | `datetime`         |
# **`unconfirmed_email`**       | `string(255)`      |
# **`failed_attempts`**         | `integer`          | `default(0), not null`
# **`unlock_token`**            | `string(255)`      |
# **`locked_at`**               | `datetime`         |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :first_name, :last_name, :avatar, :email, :password,
    # :password_confirmation, :remember_me, :account_name
  belongs_to :account
  has_many :comments
  has_many :assignments
  has_many :roles, through: :assignments

  def account_name=(account_name)
  end
  def account_name
  end
  def full_name
    "#{first_name} #{last_name}"
  end
end
