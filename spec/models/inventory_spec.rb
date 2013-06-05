require 'spec_helper'

describe Inventory do

  it { should belong_to(:inspection) }

  it 'has a valid factory' do
    expect(build(:inventory)).to be_valid
  end
end
