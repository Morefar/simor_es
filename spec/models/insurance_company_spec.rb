require 'rails_helper'

describe InsuranceCompany, :type => :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:nit) }
  it { is_expected.to have_many(:inspections) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_uniqueness_of(:nit) }
  it { is_expected.to allow_value('Compañía Nacional de Seguros').for(:name) }
  it { is_expected.not_to allow_value("Compañía 12").for(:name) }
  it { is_expected.to allow_value('800220495', '800.220.495').for(:nit) }
  it { is_expected.not_to allow_value('', '800.220,495', '900,345,908', '983,435.456', '890', '409.345.345-8').for(:nit)}
  it { is_expected.to ensure_length_of(:nit).
    is_at_least(9).
    is_at_most(11) }

end

# ## Schema Information
#
# Table name: `insurance_companies`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`nit`**         | `string(255)`      |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
