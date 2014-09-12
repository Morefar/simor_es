require 'rails_helper'

describe Kind, :type => :model do

  it { is_expected.to have_many(:builds) }
  it { is_expected.to have_many(:bodies).through(:builds) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to allow_value('Estacas').for(:name) }
  it { is_expected.to allow_value('Tolva Rotatoria').for(:name) }

  it 'has a valid factory' do
    expect(build(:kind)).to be_valid
  end
end

# ## Schema Information
#
# Table name: `kinds`
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
