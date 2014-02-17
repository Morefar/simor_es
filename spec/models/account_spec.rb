require 'spec_helper'

describe Account do
  it "should have a valid factory" do
    expect(create(:account)).to be_valid
  end
  it { should have_many(:users) }
  it { should validate_presence_of(:organization_name) }
  it { should validate_presence_of(:subdomain) }
  it { should accept_nested_attributes_for(:user) }
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
