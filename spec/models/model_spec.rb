require 'spec_helper'

describe Model do
  it { should belong_to(:make) }
  it { should allow_value('7:24', 'CORSA', 'Mazda 2').for(:name) }
  it { should_not allow_value('', 'MAZDA_23').for(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:make_id).case_insensitive }
  it { should allow_mass_assignment_of(:name) }
  it 'has a valid factory' do
    expect(build(:make)).to be_valid
  end
end
