require 'spec_helper'

describe IdentificationType do
  it { should allow_mass_assignment_of(:name) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should allow_value('Cedula', 'pasaporte', 'NUIP', 'NIT').for(:name) }
  it { should_not allow_value('BLANCO2', 'BLANCO 2', 'Pasaporte extranjero', 'Cedula ').for(:name) }
  it 'has a valid factory' do
    expect(build(:identification_type)).to be_valid
  end
end
