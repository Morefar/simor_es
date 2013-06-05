require 'spec_helper'

describe Color do

  it { should allow_mass_assignment_of(:name) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should allow_value('WHITE' 'BLANCO PERLA METALIZADO').for(:name) }
  it { should_not allow_value('BLANCO2' 'BLANCO 2').for(:name) }
  it 'has a valid factory' do
    expect(build(:color)).to be_valid
  end
end
