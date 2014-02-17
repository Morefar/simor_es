require 'spec_helper'

describe Grant do
  it 'has a valid factory' do
    expect(build(:grant)).to be_valid
  end
  it { should belong_to :role }
  it { should belong_to :right }
end

# ## Schema Information
#
# Table name: `grants`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`role_id`**     | `integer`          |
# **`right_id`**    | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
