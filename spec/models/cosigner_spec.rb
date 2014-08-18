require 'rails_helper'

describe Cosigner, :type => :model do

  it { is_expected.to belong_to(:contract) }
  it { is_expected.to belong_to(:entity) }
  it { is_expected.to validate_presence_of(:entity_id) }
  it { is_expected.to validate_presence_of(:contract_id) }

  it 'has a valid factory' do
    identification_type = create(:identification_type, name: "NIT")
    entity = create(:entity, identification_type: identification_type)
    expect(build(:cosigner, entity: entity)).to be_valid
  end

  it 'only accepts cosigners that are not registered as lessee on the same contract' do
    identification_type = create(:identification_type, name: 'CC')
    entity = create(:entity, identification_type_id: identification_type.id)
    contract = create(:contract, lessee: entity)
    expect(build(:cosigner, entity: entity, contract: contract).errors_on(:entity_id).size).to eq(1)
  end
end

# ## Schema Information
#
# Table name: `cosigners`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`entity_id`**    | `integer`          |
# **`contract_id`**  | `integer`          |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
#
