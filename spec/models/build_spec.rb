require 'rails_helper'

describe Build, :type => :model do

  it { is_expected.to belong_to(:kind) }
  it { is_expected.to belong_to(:body) }
  it { is_expected.to validate_presence_of(:body_id) }
  it { is_expected.to validate_presence_of(:kind_id) }
  it { is_expected.to validate_uniqueness_of(:kind_id).scoped_to(:body_id)}

  it 'has a valid factory' do
    expect(build(:build)).to be_valid
  end
end

# ## Schema Information
#
# Table name: `builds`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`kind_id`**     | `integer`          |
# **`body_id`**     | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
