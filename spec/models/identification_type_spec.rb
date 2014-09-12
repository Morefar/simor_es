require 'rails_helper'

describe IdentificationType, :type => :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to allow_value('Cedula', 'pasaporte', 'NUIP', 'NIT').for(:name) }
  it { is_expected.not_to allow_value('BLANCO2', 'BLANCO 2', 'Pasaporte extranjero', 'Cedula ').for(:name) }
  it 'has a valid factory' do
    expect(build(:identification_type)).to be_valid
  end
end

# ## Schema Information
#
# Table name: `identification_types`
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
