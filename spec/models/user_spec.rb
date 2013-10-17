require 'spec_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end
  it { should belong_to :account }
  it { should have_many :comments }
  it { should have_many :assignments }
  it { should have_many(:roles).through(:assignments) }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :account }
  it { should validate_uniqueness_of(:email)
       .scoped_to(:account_id).case_insensitive }
end
