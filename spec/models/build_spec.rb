require 'spec_helper'

describe Build do

  it { should belong_to(:kind) }
  it { should belong_to(:body) }
  it { should validate_presence_of(:body_id) }
  it { should validate_presence_of(:kind_id) }
  it { should allow_mass_assignment_of(:body_id) }
  it { should allow_mass_assignment_of(:kind_id) }
  it { should validate_uniqueness_of(:kind_id).scoped_to(:body_id)}

  it 'has a valid factory' do
    expect(build(:build)).to be_valid
  end
end
