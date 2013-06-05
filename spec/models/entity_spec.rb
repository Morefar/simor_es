require 'spec_helper'

describe Entity do

  it { should belong_to(:identification_type) }
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:address) }
  it { should allow_mass_assignment_of(:city) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:phone) }
  it { should allow_mass_assignment_of(:mobile_phone) }
  it { should allow_mass_assignment_of(:state) }
  it { should allow_mass_assignment_of(:identification_type_id) }
  it { should allow_mass_assignment_of(:identification_number) }
  it { should have_many(:cosigners) }
  it { should have_many(:contracts) }
  it { should have_many(:contracts).through(:cosigners) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:identification_number) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_uniqueness_of(:identification_number).
                              scoped_to(:identification_type_id) }
  it {should validate_uniqueness_of(:email).
                              scoped_to(:identification_type_id) }
  it { should allow_value('kjs@example.com', 'tld@example.one.two', 'first_example@crazy-examples.com.co').for(:email) }
  it { should_not allow_value('hkljh', 'aslkd lkjlk@123.com', 'kjjkh@kjhkjh').for(:email) }

  it 'has a valid factory' do
    expect(build(:entity)).to be_valid
  end
end
