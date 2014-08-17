require 'rails_helper'

describe Color do

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should allow_value('WHITE' 'BLANCO PERLA METALIZADO').for(:name) }
  it 'has a valid factory' do
    expect(build(:color)).to be_valid
  end
end

# ## Schema Information
#
# Table name: `colors`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
