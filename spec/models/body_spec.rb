#encoding: UTF-8
require 'spec_helper'

describe Body do

  it { should have_many(:builds) }
  it { should have_many(:kinds).through(:builds) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should allow_value('Vehiculo').for(:name) }
  it { should allow_value('Vehiculo de Carga').for(:name) }

  it 'has a valid factory' do
    expect(build(:body)).to be_valid
  end
end

# ## Schema Information
#
# Table name: `bodies`
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
