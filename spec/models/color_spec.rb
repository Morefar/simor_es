require 'rails_helper'

describe Color, :type => :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to allow_value('WHITE' 'BLANCO PERLA METALIZADO').for(:name) }
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
