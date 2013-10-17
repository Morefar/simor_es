require 'spec_helper'

describe Right do
  it 'should have a valid factory' do
    expect(build(:right)).to be_valid
  end
  it { should have_many :grants }
  it { should have_many(:roles).through(:grants) }
end
