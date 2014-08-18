require 'rails_helper'

describe Model, :type => :model do
  it 'has a valid factory' do
    expect(build(:make)).to be_valid
  end
  it { is_expected.to belong_to(:make) }
  it { is_expected.to allow_value('7:24', 'CORSA', 'Mazda 2').for(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:make_id) }
end

# ## Schema Information
#
# Table name: `models`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`make_id`**     | `integer`          |
# **`name`**        | `string(255)`      |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
