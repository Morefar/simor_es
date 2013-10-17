require 'spec_helper'

describe Grant do
  it 'has a valid factory' do
    expect(build(:grant)).to be_valid
  end
  it { should belong_to :role }
  it { should belong_to :right }
end
