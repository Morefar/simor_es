require 'rails_helper'

describe Make do
  it { should have_many(:models) }
  it { should allow_value('MAZDA', 'CHEVROLET', 'CHENAI').for(:name) }
  it { should_not allow_value('', '23', 'CHEVROLET2').for(:name) }
  it { should validate_uniqueness_of(:name) }
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
