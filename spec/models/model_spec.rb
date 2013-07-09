require 'spec_helper'

describe Model do
  it { should belong_to(:make) }
  it { should allow_value('7:24', 'CORSA', 'Mazda 2').for(:name) }
  it { should_not allow_value('', 'MAZDA_23').for(:name) }
  it 'Validates uniquess of the model name scoped to the make' do
    make = create(:make)
    model = create(:model, make_id: make.id)
    expect(build(:model, make_id: make.id)).to have(1).errors_on(:name)
    expect(build(:model, make_id: (make.id+1))).to be_valid
  end
  it { should allow_mass_assignment_of(:name) }
  it 'has a valid factory' do
    expect(build(:make)).to be_valid
  end
end
