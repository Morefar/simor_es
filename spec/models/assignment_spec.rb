require 'rails_helper'

describe Assignment, :type => :model do
  it 'has a valid factory' do
    expect(build(:assignment)).to be_valid
  end
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :role }
end

# ## Schema Information
#
# Table name: `assignments`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`role_id`**     | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`user_id`**     | `integer`          |
#
