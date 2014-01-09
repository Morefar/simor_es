require 'spec_helper'

describe Model do
  it 'has a valid factory' do
    expect(build(:make)).to be_valid
  end
  it { should belong_to(:make) }
  it { should allow_value('7:24', 'CORSA', 'Mazda 2').for(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:make_id) }
end
