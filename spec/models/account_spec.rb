require 'rails_helper'

describe Account, :type => :model do
  it "should have a valid factory" do
    expect(create(:account)).to be_valid
  end
  it { is_expected.to have_many(:users) }
  it { is_expected.to validate_presence_of(:organization_name) }
  it { is_expected.to validate_presence_of(:subdomain) }
end

# ## Schema Information
#
# Table name: `accounts`
#
# ### Columns
#
# Name                     | Type               | Attributes
# ------------------------ | ------------------ | ---------------------------
# **`id`**                 | `integer`          | `not null, primary key`
# **`organization_name`**  | `string(255)`      |
# **`subdomain`**          | `string(255)`      |
# **`created_at`**         | `datetime`         |
# **`updated_at`**         | `datetime`         |
#
