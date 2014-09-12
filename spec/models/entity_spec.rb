require 'rails_helper'

describe Entity, :type => :model do

  it { is_expected.to belong_to(:identification_type) }
  it { is_expected.to have_many(:cosigners) }
  it { is_expected.to have_many(:contracts) }
  it { is_expected.to have_many(:contracts).through(:cosigners) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:identification_number) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_uniqueness_of(:identification_number).
                              scoped_to(:identification_type_id) }
  it {is_expected.to validate_uniqueness_of(:email).
                              scoped_to(:identification_type_id) }
  it { is_expected.to allow_value('kjs@example.com', 'tld@example.one.two', 'first_example@crazy-examples.com.co').for(:email) }
  it { is_expected.not_to allow_value('hkljh', 'aslkd lkjlk@123.com', 'kjjkh@kjhkjh').for(:email) }

  it 'has a valid factory' do
    expect(build(:entity)).to be_valid
  end
end

# ## Schema Information
#
# Table name: `entities`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`address`**                 | `string(255)`      |
# **`city`**                    | `string(255)`      |
# **`email`**                   | `string(255)`      |
# **`identification_number`**   | `string(255)`      |
# **`mobile_phone`**            | `string(255)`      |
# **`name`**                    | `string(255)`      |
# **`phone`**                   | `string(255)`      |
# **`state`**                   | `string(255)`      |
# **`identification_type_id`**  | `integer`          |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
#
