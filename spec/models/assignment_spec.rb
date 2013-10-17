require 'spec_helper'

describe Assignment do
  it 'has a valid factory' do
    expect(build(:assignment)).to be_valid
  end
  it { should belong_to :user }
  it { should belong_to :role }
end
