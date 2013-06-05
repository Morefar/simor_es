require 'spec_helper'

describe Cosigner do

  it { should belong_to(:contract) }
  it { should belong_to(:entity) }
  it { should allow_mass_assignment_of(:contract_id) }
  it { should allow_mass_assignment_of(:entity_id) }

  it 'has a valid factory' do
    expect(build(:cosigner)).to be_valid
  end
end
