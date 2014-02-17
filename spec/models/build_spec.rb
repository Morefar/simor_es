require 'spec_helper'

describe Build do

  it { should belong_to(:kind) }
  it { should belong_to(:body) }
  it { should validate_presence_of(:body_id) }
  it { should validate_presence_of(:kind_id) }
  it { should validate_uniqueness_of(:kind_id).scoped_to(:body_id)}

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
