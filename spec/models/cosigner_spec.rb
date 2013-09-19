require 'spec_helper'

describe Cosigner do

  it { should belong_to(:contract) }
  it { should belong_to(:entity) }
  it { should allow_mass_assignment_of(:contract_id) }
  it { should allow_mass_assignment_of(:entity_id) }
  it { should validate_presence_of(:entity_id) }
  it { should validate_presence_of(:contract_id) }

  it 'has a valid factory' do
    identification_type = create(:identification_type, name: "NIT")
    entity = create(:entity, identification_type: identification_type)
    expect(build(:cosigner, entity: entity)).to be_valid
  end

  it 'only accepts cosigners that are not registered as lessee on the same contract' do
    identification_type = create(:identification_type, name: 'CC')
    entity = create(:entity, identification_type_id: identification_type.id)
    contract = create(:contract, lessee: entity)
    expect(build(:cosigner, entity: entity, contract: contract)).to have(1).errors_on(:entity_id)
  end
end
