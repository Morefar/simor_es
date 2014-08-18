require 'rails_helper'

describe User, :type => :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end
  it { is_expected.to belong_to :account }
  it { is_expected.to have_many :comments }
  it { is_expected.to have_many :assignments }
  it { is_expected.to have_many(:roles).through(:assignments) }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :account }
  it { is_expected.to validate_uniqueness_of(:email)
       .scoped_to(:account_id).case_insensitive }
end

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
