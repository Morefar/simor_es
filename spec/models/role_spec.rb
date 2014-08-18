require 'rails_helper'

describe Role, :type => :model do
  it 'should have a valid factory' do
    expect(build(:role)).to be_valid
  end
  it { is_expected.to have_many :assignments }
  it { is_expected.to have_many(:users).through(:assignments) }
  it { is_expected.to have_many :grants }
  it { is_expected.to have_many(:rights).through(:grants) }
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
