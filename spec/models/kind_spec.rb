require 'spec_helper'

describe Kind do

  it { should have_many(:builds) }
  it { should have_many(:bodies).through(:builds) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should allow_value('Estacas').for(:name) }
  it { should allow_value('Tolva Rotatoria').for(:name) }
  it { should_not allow_value('Furgon ').for(:name) }
  it { should_not allow_value('Furgon1').for(:name) }
  it { should allow_mass_assignment_of(:name) }

  it 'has a valid factory' do
    expect(build(:kind)).to be_valid
  end
end
