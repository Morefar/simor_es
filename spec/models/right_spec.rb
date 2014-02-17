require 'spec_helper'

describe Right do
  it 'should have a valid factory' do
    expect(build(:right)).to be_valid
  end
  it { should have_many :grants }
  it { should have_many(:roles).through(:grants) }
end

# ## Schema Information
#
# Table name: `rights`
#
# ### Columns
#
# Name             | Type               | Attributes
# ---------------- | ------------------ | ---------------------------
# **`id`**         | `integer`          | `not null, primary key`
# **`resource`**   | `string(255)`      |
# **`operation`**  | `string(255)`      |
#
