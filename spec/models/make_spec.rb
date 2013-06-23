require 'spec_helper'

describe Make do
  it { should have_many(:models) }
  it { should allow_value('MAZDA', 'CHEVROLET', 'CHENAI').for(:name) }
  it { should_not allow_value('', '23', 'CHEVROLET2').for(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should allow_mass_assignment_of(:name) }
  it 'has a valid factory' do
    expect(build(:make)).to be_valid
  end
end
