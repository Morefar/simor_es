require 'spec_helper'

describe Category do
  it 'has a valid factory' do
    expect(build(:category)).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should ensure_length_of(:name).
              is_at_least(2).
              is_at_most(20) }
  it { should allow_value('Financiero').for(:name) }
  it { should_not allow_value('Financiero Importación').for(:name) }
end
