require 'rails_helper'

describe Role do
  it 'should have a valid factory' do
    expect(build(:role)).to be_valid
  end
  it { should have_many :assignments }
  it { should have_many(:users).through(:assignments) }
  it { should have_many :grants }
  it { should have_many(:rights).through(:grants) }
end

# ## Schema Information
#
# Table name: `roles`
#
# ### Columns
#
# Name        | Type               | Attributes
# ----------- | ------------------ | ---------------------------
# **`id`**    | `integer`          | `not null, primary key`
# **`name`**  | `string(255)`      |
#
