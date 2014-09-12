require 'rails_helper'

describe Make, :type => :model do
  it { is_expected.to have_many(:models) }
  it { is_expected.to allow_value('MAZDA', 'CHEVROLET', 'CHENAI').for(:name) }
  it { is_expected.not_to allow_value('', '23', 'CHEVROLET2').for(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it 'has a valid factory' do
    expect(build(:make)).to be_valid
  end
end

# ## Schema Information
#
# Table name: `makes`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`runt_code`**   | `integer`          |
#
