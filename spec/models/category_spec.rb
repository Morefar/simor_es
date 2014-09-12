require 'rails_helper'

describe Category, :type => :model do
  it 'has a valid factory' do
    expect(build(:category)).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to ensure_length_of(:name).
              is_at_least(2).
              is_at_most(20) }
  it { is_expected.to allow_value('Financiero').for(:name) }
  it { is_expected.not_to allow_value('Financiero Importación').for(:name) }
end

# ## Schema Information
#
# Table name: `categories`
#
# ### Columns
#
# Name        | Type               | Attributes
# ----------- | ------------------ | ---------------------------
# **`id`**    | `integer`          | `not null, primary key`
# **`name`**  | `string(255)`      |
#
